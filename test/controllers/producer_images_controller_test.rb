require 'test_helper'

class ProducerImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @producer_image = producer_images(:one)
  end

  test "should get index" do
    get producer_images_url
    assert_response :success
  end

  test "should get new" do
    get new_producer_image_url
    assert_response :success
  end

  test "should create producer_image" do
    assert_difference('ProducerImage.count') do
      post producer_images_url, params: { producer_image: { primary_image: @producer_image.primary_image, producer_id: @producer_image.producer_id, src: @producer_image.src } }
    end

    assert_redirected_to producer_image_url(ProducerImage.last)
  end

  test "should show producer_image" do
    get producer_image_url(@producer_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_producer_image_url(@producer_image)
    assert_response :success
  end

  test "should update producer_image" do
    patch producer_image_url(@producer_image), params: { producer_image: { primary_image: @producer_image.primary_image, producer_id: @producer_image.producer_id, src: @producer_image.src } }
    assert_redirected_to producer_image_url(@producer_image)
  end

  test "should destroy producer_image" do
    assert_difference('ProducerImage.count', -1) do
      delete producer_image_url(@producer_image)
    end

    assert_redirected_to producer_images_url
  end
end
