require 'test_helper'

class QuestionitemsControllerTest < ActionController::TestCase
  setup do
    @questionitem = questionitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:questionitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create questionitem" do
    assert_difference('Questionitem.count') do
      post :create, questionitem: { id: @questionitem.id, question: @questionitem.question, questionItem: @questionitem.questionItem, selectionNumber: @questionitem.selectionNumber }
    end

    assert_redirected_to questionitem_path(assigns(:questionitem))
  end

  test "should show questionitem" do
    get :show, id: @questionitem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @questionitem
    assert_response :success
  end

  test "should update questionitem" do
    put :update, id: @questionitem, questionitem: { id: @questionitem.id, question: @questionitem.question, questionItem: @questionitem.questionItem, selectionNumber: @questionitem.selectionNumber }
    assert_redirected_to questionitem_path(assigns(:questionitem))
  end

  test "should destroy questionitem" do
    assert_difference('Questionitem.count', -1) do
      delete :destroy, id: @questionitem
    end

    assert_redirected_to questionitems_path
  end
end
