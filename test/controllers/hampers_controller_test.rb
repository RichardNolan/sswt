require 'test_helper'

class HampersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hamper = hampers(:one)
  end

  test "should get index" do
    get hampers_url
    assert_response :success
  end

  test "should get new" do
    get new_hamper_url
    assert_response :success
  end

  test "should create hamper" do
    assert_difference('Hamper.count') do
      post hampers_url, params: { hamper: { customer_id: @hamper.customer_id, greeting: @hamper.greeting, name: @hamper.name, price: @hamper.price } }
    end

    assert_redirected_to hamper_url(Hamper.last)
  end

  test "should show hamper" do
    get hamper_url(@hamper)
    assert_response :success
  end

  test "should get edit" do
    get edit_hamper_url(@hamper)
    assert_response :success
  end

  test "should update hamper" do
    patch hamper_url(@hamper), params: { hamper: { customer_id: @hamper.customer_id, greeting: @hamper.greeting, name: @hamper.name, price: @hamper.price } }
    assert_redirected_to hamper_url(@hamper)
  end

  test "should destroy hamper" do
    assert_difference('Hamper.count', -1) do
      delete hamper_url(@hamper)
    end

    assert_redirected_to hampers_url
  end
end
