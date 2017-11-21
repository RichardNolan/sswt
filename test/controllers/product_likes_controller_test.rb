require 'test_helper'

class ProductLikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_like = product_likes(:one)
  end

  test "should get index" do
    get product_likes_url
    assert_response :success
  end

  test "should get new" do
    get new_product_like_url
    assert_response :success
  end

  test "should create product_like" do
    assert_difference('ProductLike.count') do
      post product_likes_url, params: { product_like: { customer_id: @product_like.customer_id, product_id: @product_like.product_id } }
    end

    assert_redirected_to product_like_url(ProductLike.last)
  end

  test "should show product_like" do
    get product_like_url(@product_like)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_like_url(@product_like)
    assert_response :success
  end

  test "should update product_like" do
    patch product_like_url(@product_like), params: { product_like: { customer_id: @product_like.customer_id, product_id: @product_like.product_id } }
    assert_redirected_to product_like_url(@product_like)
  end

  test "should destroy product_like" do
    assert_difference('ProductLike.count', -1) do
      delete product_like_url(@product_like)
    end

    assert_redirected_to product_likes_url
  end
end
