require "application_system_test_case"

class BelongingsTest < ApplicationSystemTestCase
  setup do
    @belonging = belongings(:one)
  end

  test "visiting the index" do
    visit belongings_url
    assert_selector "h1", text: "Belongings"
  end

  test "should create belonging" do
    visit belongings_url
    click_on "New belonging"

    fill_in "Description", with: @belonging.description
    fill_in "Title", with: @belonging.title
    fill_in "Will", with: @belonging.will_id
    click_on "Create Belonging"

    assert_text "Belonging was successfully created"
    click_on "Back"
  end

  test "should update Belonging" do
    visit belonging_url(@belonging)
    click_on "Edit this belonging", match: :first

    fill_in "Description", with: @belonging.description
    fill_in "Title", with: @belonging.title
    fill_in "Will", with: @belonging.will_id
    click_on "Update Belonging"

    assert_text "Belonging was successfully updated"
    click_on "Back"
  end

  test "should destroy Belonging" do
    visit belonging_url(@belonging)
    click_on "Destroy this belonging", match: :first

    assert_text "Belonging was successfully destroyed"
  end
end
