require "test_helper"

class DelegateControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get delegate_index_url
    assert_response :success
  end

  test "should get show" do
    get delegate_show_url
    assert_response :success
  end

  test "should get new" do
    get delegate_new_url
    assert_response :success
  end

  test "should get edit" do
    get delegate_edit_url
    assert_response :success
  end

  test "should get create" do
    get delegate_create_url
    assert_response :success
  end

  test "should get update" do
    get delegate_update_url
    assert_response :success
  end
end
