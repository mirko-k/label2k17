require 'test_helper'

class AddressTest < ActiveSupport::TestCase

  test "should not save without any attributes" do
    address = Address.new
    assert_not address.save, "Saved the address without any attributes"
  end

  ['country_id','zip_code','city','street','name_1'].each do |attribute|
    test "should not save expected without #{attribute}" do
      address = Address.new(addresses(:max_muster).dup.attributes.except(attribute))
      assert_not address.save, "Saved the address without the expected attribute '#{attribute}'"
    end
  end

  test "should save with all attributes" do
    address = Address.new(addresses(:max_muster).dup.attributes)
    assert address.save, address.errors.full_messages.join
  end

end
