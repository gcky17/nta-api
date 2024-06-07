require "test_helper"

class ApiManagementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_management = api_managements(:one)
  end

  test "should get index" do
    get api_managements_url
    assert_response :success
  end

  test "should get new" do
    get new_api_management_url
    assert_response :success
  end

  test "should create api_management" do
    assert_difference("ApiManagement.count") do
      post api_managements_url, params: { api_management: { comment: @api_management.comment, count: @api_management.count, request: @api_management.request, response: @api_management.response, wait-time: @api_management.wait-time } }
    end

    assert_redirected_to api_management_url(ApiManagement.last)
  end

  test "should show api_management" do
    get api_management_url(@api_management)
    assert_response :success
  end

  test "should get edit" do
    get edit_api_management_url(@api_management)
    assert_response :success
  end

  test "should update api_management" do
    patch api_management_url(@api_management), params: { api_management: { comment: @api_management.comment, count: @api_management.count, request: @api_management.request, response: @api_management.response, wait-time: @api_management.wait-time } }
    assert_redirected_to api_management_url(@api_management)
  end

  test "should destroy api_management" do
    assert_difference("ApiManagement.count", -1) do
      delete api_management_url(@api_management)
    end

    assert_redirected_to api_managements_url
  end
end
