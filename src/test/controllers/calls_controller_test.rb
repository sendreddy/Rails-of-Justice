require 'test_helper'

class CallsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @call = calls(:one)
  end

  test "should get index" do
    get calls_url
    assert_response :success
  end

  test "should get new" do
    get new_call_url
    assert_response :success
  end

  test "should create call" do
    assert_difference('Call.count') do
      post calls_url, params: { call: { caller_type: @call.caller_type, date: @call.date, inmate_num: @call.inmate_num, institution: @call.institution, location: @call.location, name: @call.name, notes: @call.notes, phone_number: @call.phone_number, point_of_contact: @call.point_of_contact } }
    end

    assert_redirected_to call_url(Call.last)
  end

  test "should show call" do
    get call_url(@call)
    assert_response :success
  end

  test "should get edit" do
    get edit_call_url(@call)
    assert_response :success
  end

  test "should update call" do
    patch call_url(@call), params: { call: { caller_type: @call.caller_type, date: @call.date, inmate_num: @call.inmate_num, institution: @call.institution, location: @call.location, name: @call.name, notes: @call.notes, phone_number: @call.phone_number, point_of_contact: @call.point_of_contact } }
    assert_redirected_to call_url(@call)
  end

  test "should destroy call" do
    assert_difference('Call.count', -1) do
      delete call_url(@call)
    end

    assert_redirected_to calls_url
  end
end
