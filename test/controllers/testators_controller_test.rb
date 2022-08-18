require "test_helper"

class TestatorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @testator = testators(:one)
  end

  test "should get index" do
    get testators_url
    assert_response :success
  end

  test "should get new" do
    get new_testator_url
    assert_response :success
  end

  test "should create testator" do
    assert_difference("Testator.count") do
      post testators_url, params: { testator: {  } }
    end

    assert_redirected_to testator_url(Testator.last)
  end

  test "should show testator" do
    get testator_url(@testator)
    assert_response :success
  end

  test "should get edit" do
    get edit_testator_url(@testator)
    assert_response :success
  end

  test "should update testator" do
    patch testator_url(@testator), params: { testator: {  } }
    assert_redirected_to testator_url(@testator)
  end

  test "should destroy testator" do
    assert_difference("Testator.count", -1) do
      delete testator_url(@testator)
    end

    assert_redirected_to testators_url
  end
end
