require 'test_helper'

class CasesControllerTest < ActionController::TestCase
  setup do
    @case = cases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create case" do
    assert_difference('Case.count') do
      post :create, case: @case.attributes
    end

    assert_redirected_to case_path(assigns(:case))
  end

  test "should show case" do
    get :show, id: @case.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @case.to_param
    assert_response :success
  end

  test "should update case" do
    put :update, id: @case.to_param, case: @case.attributes
    assert_redirected_to case_path(assigns(:case))
  end

  test "should destroy case" do
    assert_difference('Case.count', -1) do
      delete :destroy, id: @case.to_param
    end

    assert_redirected_to cases_path
  end
end
