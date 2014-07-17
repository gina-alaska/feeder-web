require 'test_helper'

class HighlightsControllerTest < ActionController::TestCase
  setup do
    @entry = entries(:entry_one)
    @highlight = highlights(:one)
    @user = users(:admin)
    session[:user_id] = @user.id
  end

  test "should get new" do
    get :new, entry_id: @entry.id
    assert_response :success
  end

  test "should create highlight" do
    assert_difference('Highlight.count') do
      post :create, entry_id: @entry.id, highlight: { description: @highlight.description, user_id: @highlight.user_id }
    end

    assert_redirected_to entry_path(assigns(:entry))
  end

  test "should show highlight" do
    get :show, id: @highlight, entry_id: @entry.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @highlight, entry_id: @entry.id
    assert_response :success
  end

  test "should update highlight" do
    patch :update, id: @highlight, entry_id: @entry.id, highlight: { description: @highlight.description, user_id: @highlight.user_id }
    assert_redirected_to entry_path(assigns(:entry))
  end

  test "should destroy highlight" do
    assert_difference('Highlight.count', -1) do
      delete :destroy, id: @highlight, entry_id: @entry.id
    end

    assert_redirected_to entry_path(assigns(:entry))
  end
end
