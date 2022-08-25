require "test_helper"

class BelongingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @belonging = belongings(:one)
  end

  test "should get index" do
    get belongings_url
    assert_response :success
  end

  test "should get new" do
    get new_belonging_url
    assert_response :success
  end

  test "should create belonging" do
    assert_difference("Belonging.count") do
      post belongings_url, params: { belonging: { description: @belonging.description, title: @belonging.title, will_id: @belonging.will_id } }
    end

    assert_redirected_to belonging_url(Belonging.last)
  end

  test "should show belonging" do
    get belonging_url(@belonging)
    assert_response :success
  end

  test "should get edit" do
    get edit_belonging_url(@belonging)
    assert_response :success
  end

  test "should update belonging" do
    patch belonging_url(@belonging), params: { belonging: { description: @belonging.description, title: @belonging.title, will_id: @belonging.will_id } }
    assert_redirected_to belonging_url(@belonging)
  end

  test "should destroy belonging" do
    assert_difference("Belonging.count", -1) do
      delete belonging_url(@belonging)
    end

    assert_redirected_to belongings_url
  end
end
