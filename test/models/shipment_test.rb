require 'test_helper'

class ShipmentTest < ActiveSupport::TestCase

  test "should not save shipment without attributes" do
    shipment = Shipment.new
    assert_not shipment.save, "Saved the shipment without a attributes"
  end

  test "should save shipment with all attributes" do
    shipment = Shipment.new(hauler_id: haulers(:dpd).id, merchant_id: merchants(:fo).id, parcel_count: 1, cod_amount: 0.0, )
    shipment.address = Address.new(addresses(:max_muster).dup.attributes)
    shipment.parcels.new(tracking_no: 0101000000001 )
    assert shipment.save, shipment.errors.full_messages.join
  end

end
