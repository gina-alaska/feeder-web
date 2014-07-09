require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
  setup do
    @feed = feeds(:barrow_webcam)
    @entry = @feed.entries.first
  end

  test "should get index" do    
    get :index, feed_id: @feed
    assert_response :success
    assert_not_nil assigns(:entries)
  end

  test "should show entry" do
    get :show, feed_id: @feed, id: @entry
    assert_response :success
  end
end
