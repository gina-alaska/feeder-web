require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
  setup do
    @feed = feeds(:barrow_webcam)
    @slideshow = slideshows(:barrow)
    @highlight_slideshow = slideshows(:barrow_highlights)
    @entry = @feed.entries.first
  end

  test "should get list of entries for feeds" do
    get :index, feed_id: @feed
    assert_response :success
    assert_not_nil assigns(:entries)
  end

  test "should render feed with no entries" do
    get :index, feed_id: feeds(:empty_feed)

    assert_response :success
    assert_not_nil assigns(:entries)
  end

  test "should show entry" do
    get :show, feed_id: @feed, id: @entry
    assert_response :success
  end
end
