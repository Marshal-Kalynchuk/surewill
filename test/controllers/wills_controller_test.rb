require "test_helper"

class WillsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @will = wills(:one)
  end

  test "should get index" do
    get wills_url
    assert_response :success
  end

  test "should get new" do
    get new_will_url
    assert_response :success
  end

  test "should create will" do
    assert_difference("Will.count") do
      post wills_url, params: { will: { prepaid: @will.prepaid, status: @will.status, user_id: @will.user_id } }
    end

    assert_redirected_to will_url(Will.last)
  end

  test "should show will" do
    get will_url(@will)
    assert_response :success
  end

  test "should get edit" do
    get edit_will_url(@will)
    assert_response :success
  end

  test "should update will" do
    patch will_url(@will), params: { will: { prepaid: @will.prepaid, status: @will.status, user_id: @will.user_id } }
    assert_redirected_to will_url(@will)
  end

  test "should destroy will" do
    assert_difference("Will.count", -1) do
      delete will_url(@will)
    end

    assert_redirected_to wills_url
  end
end
