require "test_helper"

class BequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bequest = bequests(:one)
  end

  test "should get index" do
    get bequests_url
    assert_response :success
  end

  test "should get new" do
    get new_bequest_url
    assert_response :success
  end

  test "should create bequest" do
    assert_difference("Bequest.count") do
      post bequests_url, params: { bequest: { create: @bequest.create, destroy: @bequest.destroy, edit: @bequest.edit, new: @bequest.new, update: @bequest.update } }
    end

    assert_redirected_to bequest_url(Bequest.last)
  end

  test "should show bequest" do
    get bequest_url(@bequest)
    assert_response :success
  end

  test "should get edit" do
    get edit_bequest_url(@bequest)
    assert_response :success
  end

  test "should update bequest" do
    patch bequest_url(@bequest), params: { bequest: { create: @bequest.create, destroy: @bequest.destroy, edit: @bequest.edit, new: @bequest.new, update: @bequest.update } }
    assert_redirected_to bequest_url(@bequest)
  end

  test "should destroy bequest" do
    assert_difference("Bequest.count", -1) do
      delete bequest_url(@bequest)
    end

    assert_redirected_to bequests_url
  end
end
