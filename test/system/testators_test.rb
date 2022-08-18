require "application_system_test_case"

class TestatorsTest < ApplicationSystemTestCase
  setup do
    @testator = testators(:one)
  end

  test "visiting the index" do
    visit testators_url
    assert_selector "h1", text: "Testators"
  end

  test "should create testator" do
    visit testators_url
    click_on "New testator"

    click_on "Create Testator"

    assert_text "Testator was successfully created"
    click_on "Back"
  end

  test "should update Testator" do
    visit testator_url(@testator)
    click_on "Edit this testator", match: :first

    click_on "Update Testator"

    assert_text "Testator was successfully updated"
    click_on "Back"
  end

  test "should destroy Testator" do
    visit testator_url(@testator)
    click_on "Destroy this testator", match: :first

    assert_text "Testator was successfully destroyed"
  end
end
