require "application_system_test_case"

class WillsTest < ApplicationSystemTestCase
  setup do
    @will = wills(:one)
  end

  test "visiting the index" do
    visit wills_url
    assert_selector "h1", text: "Wills"
  end

  test "should create will" do
    visit wills_url
    click_on "New will"

    check "Prepaid" if @will.prepaid
    fill_in "Status", with: @will.status
    fill_in "User", with: @will.user_id
    click_on "Create Will"

    assert_text "Will was successfully created"
    click_on "Back"
  end

  test "should update Will" do
    visit will_url(@will)
    click_on "Edit this will", match: :first

    check "Prepaid" if @will.prepaid
    fill_in "Status", with: @will.status
    fill_in "User", with: @will.user_id
    click_on "Update Will"

    assert_text "Will was successfully updated"
    click_on "Back"
  end

  test "should destroy Will" do
    visit will_url(@will)
    click_on "Destroy this will", match: :first

    assert_text "Will was successfully destroyed"
  end
end
