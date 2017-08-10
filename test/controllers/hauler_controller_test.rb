require 'test_helper'

class HaulerControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get haulers_url
    assert_equal "index", @controller.action_name
    assert_equal "application/x-www-form-urlencoded", @request.media_type
    assert_match "Haulers", @response.body
  end

  test "should get a hauler" do
    get hauler_path( haulers(:dpd) )
    assert_equal "show", @controller.action_name
    assert_equal "application/x-www-form-urlencoded", @request.media_type
    assert_match "DPD", @response.body
  end

  test "should create hauler" do
    assert_difference('Hauler.count') do
      post( haulers_url, {
        hauler: {
          name: 'GLS'
        }
      })
    end
    assert_redirected_to hauler_path(Hauler.last)
    assert_equal 'Hauler was successfully created.', flash[:notice]
  end

  test "should not create hauler" do
    post( haulers_url, {
      hauler: {
        name: ''
      }
    })
    assert_match "errors", @response.body
  end

end
