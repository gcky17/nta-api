require 'net/http'
require 'uri'
require 'csv'
require 'securerandom'

class ApiManagementsController < ApplicationController
  before_action :set_api_management, only: %i[ show edit update destroy ]
  before_action :set_file_data, only: %i[diff_api]

  # GET /api_managements or /api_managements.json
  def index
    @api_managements = ApiManagement.all
  end

  # GET /api_managements/1 or /api_managements/1.json
  def show
  end

  # GET /api_managements/new
  def new
    @api_management = ApiManagement.new
  end

  # GET /api_managements/1/edit
  def edit
  end

  # POST /api_managements or /api_managements.json
  def create
    @api_management = ApiManagement.new(api_management_params)

    respond_to do |format|
      if @api_management.save
        format.html { redirect_to api_management_url(@api_management), notice: "Api management was successfully created." }
        format.json { render :show, status: :created, location: @api_management }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @api_management.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api_managements/1 or /api_managements/1.json
  def update
    respond_to do |format|
      if @api_management.update(api_management_params)
        format.html { redirect_to api_management_url(@api_management), notice: "Api management was successfully updated." }
        format.json { render :show, status: :ok, location: @api_management }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @api_management.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api_managements/1 or /api_managements/1.json
  def destroy
    @api_management.destroy!

    respond_to do |format|
      format.html { redirect_to api_managements_url, notice: "Api management was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # API
  def api
#    uri = URI('https://api.houjin-bangou.nta.go.jp/4/diff')
    req= get_request(params[:id])
    uri = URI("#{req}")
#    api_params = { :id => 'KG59hTGDBUJsF', :from => '2024-05-01', :to => '2024-05-30', :type => '02', :address => '01' }
    base_params = URI.decode_www_form(uri.query || "")
    api_params = base_params + [["id", "KG59hTGDBUJsF"]]
    uri.query = URI.encode_www_form(api_params)
    res = Net::HTTP.get_response(uri)
    res.body if res.is_a?(Net::HTTPSuccess)
    update_response(params[:id], res.body)
    redirect_to api_managements_path, notice: 'Successfully responded.'
  end

  # NTA API OF DIFF
  def diff_api
    uri = URI('https://api.houjin-bangou.nta.go.jp/4/diff')
    id = 'KG59hTGDBUJsF'
    original_from = params[:start_date]
    from = original_from.gsub("/", "-")
    original_to = params[:end_date]
    to = original_to.gsub("/", "-")
    type = params[:type]
    address = params[:address]
    divide = params[:divide]
    api_params = { :id => "#{id}", :from => "#{from}", :to => "#{to}", :type => "#{type}", :address => "#{address}", :divide => "#{divide}" }
    uri.query = URI.encode_www_form(api_params)
    res = Net::HTTP.get_response(uri)
    
    puts res.class
    puts "取得期間APIの返却ステータス"
      puts res.header
    puts "取得期間APIの返却値"
      puts res.body
    puts "分割数"
      num_divide = CSV.parse(res.body).first[3].to_i
      puts num_divide

    # 分割数の分だけAPIを叩いて結合データを作成する
    combined_res = ""
    num_divide.times do |i|
      api_params = { :id => "#{id}", :from => "#{from}", :to => "#{to}", :type => "#{type}", :address => "#{address}", :divide => "#{i + 1}" }
      uri.query = URI.encode_www_form(api_params)
      res = Net::HTTP.get_response(uri)
      combined_res << res.body
    end

    puts "結合データの全レコード"
    puts combined_res

#    res.body if res.is_a?(Net::HTTPSuccess)

    if res.is_a?(Net::HTTPSuccess)
      case type
        when '01'
          api_id = set_api_csv_data(res.body)
        when '02'
          api_id = set_api_csv_data(combined_res)
        when '12'
          api_id = set_api_xml_data(res.body)
        else
          api_id = nil
      end 
      redirect_to search_result_path(diff_api_res_id: api_id, diff_api_date_from: from, diff_api_date_to: to, diff_api_address: address)
    else
      error_msg = res.body
      redirect_to search_term_path, alert: error_msg
    end
  end

  # NTA API OF NUM
  def num_api
    uri = URI('https://api.houjin-bangou.nta.go.jp/4/num')
    id = 'KG59hTGDBUJsF'
    original_corporation_no = params[:no]
    corporation_no = original_corporation_no
    type = '02'
    history = '1'
    api_params = { :id => "#{id}", :number => "#{corporation_no}", :type => "#{type}", :history => "#{history}" }
    uri.query = URI.encode_www_form(api_params)
    res = Net::HTTP.get_response(uri)
    res.body if res.is_a?(Net::HTTPSuccess)

    case type
      when '01'
        api_id = set_api_csv_data(res.body)
      when '02'
        api_id = set_api_csv_data(res.body)
      when '12'
        api_id = set_api_xml_data(res.body)
      else
        api_id = nil
    end 

    redirect_to search_result_detail_path(num_api_res_id: api_id)
  end

  def name_api

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_management
      @api_management = ApiManagement.find(params[:id])
    end

    def set_file_data
      file = params[:file]

      if file
        csv_data = CSV.read(file.path, headers: true)
        file_id = SecureRandom.uuid
        temp_file_path = Rails.root.join('tmp', "#{file_id}.csv")
        CSV.open(temp_file_path, 'w') do |csv|
          csv << csv_data.headers
          csv_data.each do |row|
            csv << row
          end
        end

        session[:csv_file_id] = file_id
      else
        session[:csv_file_id] = nil
      end
    end

    def set_api_csv_data(data)

      puts "Encode Check"
        p data.encoding
      puts "ASCII 8BIT -> UTF-8"
        p data.force_encoding("UTF-8").encoding

      if data
        api_id = SecureRandom.uuid
        temp_file_path = Rails.root.join('tmp', "#{api_id}.csv")
        CSV.open(temp_file_path, 'w') do |csv|
          CSV.parse(data.force_encoding("UTF-8")) do |row|
            csv << row
          end
        end
        api_id
      else
        nil
      end
    end

    def get_request(id)
      data = ApiManagement.find(id)
      data.request
    end

    def update_response(id, res_body)
      data = ApiManagement.find(id)
      data.update(response: res_body, updated_at: DateTime.now)
    end

    # Only allow a list of trusted parameters through.
    def api_management_params
      params.require(:api_management).permit(:request, :response, :count, :wtime, :comment)
    end
end
