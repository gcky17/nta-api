require 'csv'
class SearchController < ApplicationController
  def index
  end

  def term
    keyword = params[:keyword]
    uploaded_file = params[:file]

#    response = ApiService
  end

  def name
  end

  def number
  end

  def result
    file_id = session.delete(:csv_file_id)
    api_id = params[:diff_api_res_id]
    @date_from = params[:diff_api_date_from]
    @date_to = params[:diff_api_date_to]
    @address = convert_pref(params[:diff_api_address])

    if file_id
      temp_file_path = Rails.root.join('tmp', "#{file_id}.csv")
      if File.exist? (temp_file_path)
        file_data = CSV.read(temp_file_path, headers: true)
      else
        file_data = nil
      end
    else
      file_data = nil
    end  
 
    if api_id
      temp_api_path = Rails.root.join('tmp', "#{api_id}.csv")
      if File.exist? (temp_api_path)
        api_data = CSV.read(temp_api_path)
      else
        api_data = nil
      end
    else
      api_data = nil
    end

#    @results = []
#    @results << test_match(file_data, api_data)
#    @results << match_data(file_data, api_data)
    @results = match_data(file_data, api_data)
    @file_data_cnt = file_data.count
    @api_data_cnt = api_data.count
    @match_cnt = @results.count
  end

  def result_detail
    api_id = params[:num_api_res_id]

    if api_id
      temp_api_path = Rails.root.join('tmp', "#{api_id}.csv")
      if File.exist? (temp_api_path)
        api_data = CSV.read(temp_api_path)
      else
        api_data = nil
      end
    else
      api_data = nil
    end

    puts "Check!"
    p api_data
    @result_detail = api_data
  end

  def test_match(csv1, csv2)
    p "File Data"
    csv1.each do |row1|
#      puts row1.to_h
      puts row1["法人番号"]
    end

    p "API Data"
    csv2.each do |row2|
      puts row2[1]
    end
  end

  def match_data(csv1, csv2)
    combined_data = []
    csv1_ids = csv1["法人番号"].map(&:to_i)
    csv2.each do |row2|
      if csv1_ids.include? (row2[1].to_i)
        csv1.each do |row1|
          if row1["法人番号"].to_i == row2[1].to_i
            row1["本店所在地（都道府県）_変換後"] = convert_pref(row1["本店所在地（都道府県）"])
            combined_data << [row1, row2]
          end
        end
      end
    end
    return combined_data
  end

  def convert_pref(pref_code)
    case pref_code
      when "01"
        return "北海道"
      when "02"
        return "青森県"
      when "03"
        return "岩手県"
      when "04"
        return "宮城県"
      when "05"
        return "秋田県"
      when "06"
        return "山形県"
      when "07"
        return "福島県"
      when "08"
        return "茨城県"
      when "09"
        return "栃木県"
      when "10"
        return "群馬県"
      when "11"
        return "埼玉県"
      when "12"
        return "千葉県"
      when "13"
        return "東京都"
      when "14"
        return "神奈川県"
      when "15"
        return "新潟県"
      when "16"
        return "富山県"
      when "17"
        return "石川県"
      when "18"
        return "福井県"
      when "19"
        return "山梨県"
      when "20"
        return "長野県"
      when "21"
        return "岐阜県"
      when "22"
        return "静岡県"
      when "23"
        return "愛知県"
      when "24"
        return "三重県"
      when "25"
        return "滋賀県"
      when "26"
        return "京都府"
      when "27"
        return "大阪府"
      when "28"
        return "兵庫県"
      when "29"
        return "奈良県"
      when "30"
        return "和歌山県"
      when "31"
        return "鳥取県"
      when "32"
        return "島根県"
      when "33"
        return "岡山県"
      when "34"
        return "広島県"
      when "35"
        return "山口県"
      when "36"
        return "徳島県"
      when "37"
        return "香川県"
      when "38"
        return "愛媛県"
      when "39"
        return "高知県"
      when "40"
        return "福岡県"
      when "41"
        return "佐賀県"
      when "42"
        return "長崎県"
      when "43"
        return "熊本県"
      when "44"
        return "大分県"
      when "45"
        return "宮崎県"
      when "46"
        return "鹿児島県"
      when "47"
        return "沖縄県"
      when ""
        return "全国"
      when nil
        return "nilやん"
      else
        return "その他やん"
    end
  end
end
