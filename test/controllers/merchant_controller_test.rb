require 'test_helper'

class MerchantControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get merchants_url
    assert_equal "index", @controller.action_name
    assert_equal "application/x-www-form-urlencoded", @request.media_type
    assert_match "Merchants", @response.body
  end

  test "should get a merchant" do
    get merchant_path( merchants(:fo) )
    assert_equal "show", @controller.action_name
    assert_equal "application/x-www-form-urlencoded", @request.media_type
    assert_match "Felgenoutlet", @response.body
  end

  test "should create merchant" do
    assert_difference('Merchant.count') do
      post( merchants_url, {
        merchant: {
          name: merchants(:fo).name,
          address_attributes: addresses(:max_muster).dup.attributes.except('id')
        }
      })
    end
    assert_redirected_to merchant_path(Merchant.last)
    assert_equal 'Merchant was successfully created.', flash[:notice]
  end

  test "should not create merchant" do
    post( merchants_url, {
      merchant: {
        name: '',
        address_attributes: addresses(:max_muster).dup.attributes.except('id')
      }
    })
    assert_match "errors", @response.body
  end


end
