require 'test_helper'

class ShipmentControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get shipments_url
    assert_equal "index", @controller.action_name
    assert_equal "application/x-www-form-urlencoded", @request.media_type
    assert_match "Shipments", @response.body
  end

  test "should get a shipment" do
    get shipment_path( shipments(:max_muster) )
    assert_equal "show", @controller.action_name
    assert_equal "application/x-www-form-urlencoded", @request.media_type
    assert_match "Muster", @response.body
  end

  test "should create shipment" do
    assert_difference('Shipment.count') do
      post( shipments_url, {
        shipment: {
          parcel_count: 1,
          hauler_id: haulers(:dpd).id,
          merchant_id: merchants(:fo).id,
          address_attributes: addresses(:max_muster).dup.attributes.except('id')
        }
      })
    end
    assert_redirected_to shipment_path(Shipment.last)
    assert_equal 'Shipment was successfully created.', flash[:notice]
  end

  test "should not create shipment" do
    post( shipments_url, {
      shipment: {
        parcel_count: 0,
        hauler_id: haulers(:dpd).id,
        merchant_id: merchants(:fo).id,
        address_attributes: addresses(:max_muster).dup.attributes.except('id')
      }
    })
    assert_match "errors", @response.body
  end


end
