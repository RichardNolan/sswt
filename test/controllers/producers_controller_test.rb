require 'test_helper'

class ProducersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @producer = producers(:one)
  end

  test "should get index" do
    get producers_url
    assert_response :success
  end

  test "should get new" do
    get new_producer_url
    assert_response :success
  end

  test "should create producer" do
    assert_difference('Producer.count') do
      post producers_url, params: { producer: { about: @producer.about, address2: @producer.address2, address: @producer.address, admin_notes: @producer.admin_notes, contact_email: @producer.contact_email, contact_phone: @producer.contact_phone, county_id: @producer.county_id, email: @producer.email, email_confirmed: @producer.email_confirmed, enabled: @producer.enabled, join_date: @producer.join_date, name: @producer.name, password: @producer.password } }
    end

    assert_redirected_to producer_url(Producer.last)
  end

  test "should show producer" do
    get producer_url(@producer)
    assert_response :success
  end

  test "should get edit" do
    get edit_producer_url(@producer)
    assert_response :success
  end

  test "should update producer" do
    patch producer_url(@producer), params: { producer: { about: @producer.about, address2: @producer.address2, address: @producer.address, admin_notes: @producer.admin_notes, contact_email: @producer.contact_email, contact_phone: @producer.contact_phone, county_id: @producer.county_id, email: @producer.email, email_confirmed: @producer.email_confirmed, enabled: @producer.enabled, join_date: @producer.join_date, name: @producer.name, password: @producer.password } }
    assert_redirected_to producer_url(@producer)
  end

  test "should destroy producer" do
    assert_difference('Producer.count', -1) do
      delete producer_url(@producer)
    end

    assert_redirected_to producers_url
  end
end
