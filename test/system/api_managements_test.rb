require "application_system_test_case"

class ApiManagementsTest < ApplicationSystemTestCase
  setup do
    @api_management = api_managements(:one)
  end

  test "visiting the index" do
    visit api_managements_url
    assert_selector "h1", text: "Api managements"
  end

  test "should create api management" do
    visit api_managements_url
    click_on "New api management"

    fill_in "Comment", with: @api_management.comment
    fill_in "Count", with: @api_management.count
    fill_in "Request", with: @api_management.request
    fill_in "Response", with: @api_management.response
    fill_in "Wait-time", with: @api_management.wait-time
    click_on "Create Api management"

    assert_text "Api management was successfully created"
    click_on "Back"
  end

  test "should update Api management" do
    visit api_management_url(@api_management)
    click_on "Edit this api management", match: :first

    fill_in "Comment", with: @api_management.comment
    fill_in "Count", with: @api_management.count
    fill_in "Request", with: @api_management.request
    fill_in "Response", with: @api_management.response
    fill_in "Wait-time", with: @api_management.wait-time
    click_on "Update Api management"

    assert_text "Api management was successfully updated"
    click_on "Back"
  end

  test "should destroy Api management" do
    visit api_management_url(@api_management)
    click_on "Destroy this api management", match: :first

    assert_text "Api management was successfully destroyed"
  end
end
