require 'test_helper'

class RequestQuestionnairesControllerTest < ActionController::TestCase
  setup do
    @request_questionnaire = request_questionnaires(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:request_questionnaires)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create request_questionnaire" do
    assert_difference('RequestQuestionnaire.count') do
      post :create, request_questionnaire: { questionnaire_id: @request_questionnaire.questionnaire_id, target_month: @request_questionnaire.target_month, target_year: @request_questionnaire.target_year, user_id: @request_questionnaire.user_id }
    end

    assert_redirected_to request_questionnaire_path(assigns(:request_questionnaire))
  end

  test "should show request_questionnaire" do
    get :show, id: @request_questionnaire
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @request_questionnaire
    assert_response :success
  end

  test "should update request_questionnaire" do
    put :update, id: @request_questionnaire, request_questionnaire: { questionnaire_id: @request_questionnaire.questionnaire_id, target_month: @request_questionnaire.target_month, target_year: @request_questionnaire.target_year, user_id: @request_questionnaire.user_id }
    assert_redirected_to request_questionnaire_path(assigns(:request_questionnaire))
  end

  test "should destroy request_questionnaire" do
    assert_difference('RequestQuestionnaire.count', -1) do
      delete :destroy, id: @request_questionnaire
    end

    assert_redirected_to request_questionnaires_path
  end
end
