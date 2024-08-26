require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get search_index_url
    assert_response :success
  end

  test "should get term" do
    get search_term_url
    assert_response :success
  end

  test "should get name" do
    get search_name_url
    assert_response :success
  end

  test "should get number" do
    get search_number_url
    assert_response :success
  end
end
