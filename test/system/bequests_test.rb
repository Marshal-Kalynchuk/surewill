require "application_system_test_case"

class BequestsTest < ApplicationSystemTestCase
  setup do
    @bequest = bequests(:one)
  end

  test "visiting the index" do
    visit bequests_url
    assert_selector "h1", text: "Bequests"
  end

  test "should create bequest" do
    visit bequests_url
    click_on "New bequest"

    fill_in "Create", with: @bequest.create
    fill_in "Destroy", with: @bequest.destroy
    fill_in "Edit", with: @bequest.edit
    fill_in "New", with: @bequest.new
    fill_in "Update", with: @bequest.update
    click_on "Create Bequest"

    assert_text "Bequest was successfully created"
    click_on "Back"
  end

  test "should update Bequest" do
    visit bequest_url(@bequest)
    click_on "Edit this bequest", match: :first

    fill_in "Create", with: @bequest.create
    fill_in "Destroy", with: @bequest.destroy
    fill_in "Edit", with: @bequest.edit
    fill_in "New", with: @bequest.new
    fill_in "Update", with: @bequest.update
    click_on "Update Bequest"

    assert_text "Bequest was successfully updated"
    click_on "Back"
  end

  test "should destroy Bequest" do
    visit bequest_url(@bequest)
    click_on "Destroy this bequest", match: :first

    assert_text "Bequest was successfully destroyed"
  end
end
