require 'test_helper'

class FeedsControllerTest < ActionController::TestCase
  setup do
    @feed = feeds(:barrow_webcam)
    @category = categories(:one)
    @user = users(:admin)
    session[:user_id] = @user.id
  end

  test "should get html index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:feeds)
  end
  
  test "should get json index" do
    get :index, format: :json
    assert_response :success
    assert_not_nil assigns(:feeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create feed" do
    assert_difference('Feed.count') do
      post :create, feed: { title: 'Testing', description: 'Some Feed', author: 'MyString', location: 'MyString', category_id: @category.id }
      assert assigns(:feed).errors.empty?, assigns(:feed).errors.full_messages
    end

    assert_redirected_to feed_entries_path(assigns(:feed))
  end

  test "should show feed" do
    get :show, id: @feed
    assert_response :success
  end
  
  test "should show empty feed" do
    get :show, id: feeds(:empty_feed)
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @feed
    assert_response :success
  end

  test "should update feed" do
    patch :update, id: @feed, feed: { title: 'Testing2' }
    assert_redirected_to feed_entries_path(assigns(:feed))
  end

  test "should destroy feed" do
    assert_difference('Feed.count', -1) do
      delete :destroy, id: @feed
    end

    assert_redirected_to feeds_path
  end
end
