require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: { admin_notes: @product.admin_notes, contains_celery: @product.contains_celery, contains_cerials: @product.contains_cerials, contains_crustaceans: @product.contains_crustaceans, contains_eggs: @product.contains_eggs, contains_fish: @product.contains_fish, contains_lupin: @product.contains_lupin, contains_milk: @product.contains_milk, contains_mullucus: @product.contains_mullucus, contains_mustard: @product.contains_mustard, contains_nuts: @product.contains_nuts, contains_peanuts: @product.contains_peanuts, contains_semsame: @product.contains_semsame, contains_soybeans: @product.contains_soybeans, contains_sulphur: @product.contains_sulphur, deleted: @product.deleted, description: @product.description, discount: @product.discount, enabled: @product.enabled, end_date: @product.end_date, min_quantity: @product.min_quantity, name: @product.name, price: @product.price, producer_id: @product.producer_id, start_date: @product.start_date } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { admin_notes: @product.admin_notes, contains_celery: @product.contains_celery, contains_cerials: @product.contains_cerials, contains_crustaceans: @product.contains_crustaceans, contains_eggs: @product.contains_eggs, contains_fish: @product.contains_fish, contains_lupin: @product.contains_lupin, contains_milk: @product.contains_milk, contains_mullucus: @product.contains_mullucus, contains_mustard: @product.contains_mustard, contains_nuts: @product.contains_nuts, contains_peanuts: @product.contains_peanuts, contains_semsame: @product.contains_semsame, contains_soybeans: @product.contains_soybeans, contains_sulphur: @product.contains_sulphur, deleted: @product.deleted, description: @product.description, discount: @product.discount, enabled: @product.enabled, end_date: @product.end_date, min_quantity: @product.min_quantity, name: @product.name, price: @product.price, producer_id: @product.producer_id, start_date: @product.start_date } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
