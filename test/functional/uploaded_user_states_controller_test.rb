require 'test_helper'

class UploadedUserStatesControllerTest < ActionController::TestCase
  setup do
    @uploaded_user_state = uploaded_user_states(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:uploaded_user_states)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create uploaded_user_state" do
    assert_difference('UploadedUserState.count') do
      post :create, uploaded_user_state: { comment: @uploaded_user_state.comment }
    end

    assert_redirected_to uploaded_user_state_path(assigns(:uploaded_user_state))
  end

  test "should show uploaded_user_state" do
    get :show, id: @uploaded_user_state
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @uploaded_user_state
    assert_response :success
  end

  test "should update uploaded_user_state" do
    put :update, id: @uploaded_user_state, uploaded_user_state: { comment: @uploaded_user_state.comment }
    assert_redirected_to uploaded_user_state_path(assigns(:uploaded_user_state))
  end

  test "should destroy uploaded_user_state" do
    assert_difference('UploadedUserState.count', -1) do
      delete :destroy, id: @uploaded_user_state
    end

    assert_redirected_to uploaded_user_states_path
  end
end
