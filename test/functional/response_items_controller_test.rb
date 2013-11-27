require 'test_helper'

class ResponseItemsControllerTest < ActionController::TestCase
  setup do
    @response_item = response_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:response_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create response_item" do
    assert_difference('ResponseItem.count') do
      post :create, response_item: { Comment: @response_item.Comment, question: @response_item.question, response_id: @response_item.response_id, selectionItem: @response_item.selectionItem, selectionNumber: @response_item.selectionNumber }
    end

    assert_redirected_to response_item_path(assigns(:response_item))
  end

  test "should show response_item" do
    get :show, id: @response_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @response_item
    assert_response :success
  end

  test "should update response_item" do
    put :update, id: @response_item, response_item: { Comment: @response_item.Comment, question: @response_item.question, response_id: @response_item.response_id, selectionItem: @response_item.selectionItem, selectionNumber: @response_item.selectionNumber }
    assert_redirected_to response_item_path(assigns(:response_item))
  end

  test "should destroy response_item" do
    assert_difference('ResponseItem.count', -1) do
      delete :destroy, id: @response_item
    end

    assert_redirected_to response_items_path
  end
end
