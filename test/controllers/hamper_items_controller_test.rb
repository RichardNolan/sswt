require 'test_helper'

class HamperItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hamper_item = hamper_items(:one)
  end

  test "should get index" do
    get hamper_items_url
    assert_response :success
  end

  test "should get new" do
    get new_hamper_item_url
    assert_response :success
  end

  test "should create hamper_item" do
    assert_difference('HamperItem.count') do
      post hamper_items_url, params: { hamper_item: { hamper_id: @hamper_item.hamper_id, price_when_ordered: @hamper_item.price_when_ordered, product_id: @hamper_item.product_id, quantity: @hamper_item.quantity } }
    end

    assert_redirected_to hamper_item_url(HamperItem.last)
  end

  test "should show hamper_item" do
    get hamper_item_url(@hamper_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_hamper_item_url(@hamper_item)
    assert_response :success
  end

  test "should update hamper_item" do
    patch hamper_item_url(@hamper_item), params: { hamper_item: { hamper_id: @hamper_item.hamper_id, price_when_ordered: @hamper_item.price_when_ordered, product_id: @hamper_item.product_id, quantity: @hamper_item.quantity } }
    assert_redirected_to hamper_item_url(@hamper_item)
  end

  test "should destroy hamper_item" do
    assert_difference('HamperItem.count', -1) do
      delete hamper_item_url(@hamper_item)
    end

    assert_redirected_to hamper_items_url
  end
end
