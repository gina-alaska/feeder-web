require 'test_helper'

class FeedTest < ActiveSupport::TestCase
  def setup
    @feed = feeds(:barrow_webcam)
  end

  test 'is valid with valid parameters' do
    assert @feed.valid?, "Unable to create Feed with valid params"
  end

  test 'is invalid without a title' do
    @feed.title = nil
    
    assert !@feed.valid?, "Created feed with invalid title"
  end

  test 'has_many entries' do
    Feed.reflect_on_association(:entries).macro.must_equal :has_many, "Feed does not have many entries"
  end

  test 'generates the correct preview url' do
    assert_equal(@feed.preview_entry, entries(:entry_two))
    # feed.preview.must_equal entries(:entry_two), "Used the wrong entry for the preview url"
  end

  test 'belongs_to category' do
    f = Feed.reflect_on_association(:category)
    
    f.macro.must_equal :belongs_to, "Feed does not belong to category"
  end

  test 'is online when status is online' do
    f = Feed.new(status: 'online')
    assert f.online?
  end

  test 'is offline when status isnt online' do
    f = Feed.new(status: 'not online')
    assert !f.online?
  end

  test 'will be invalid when more_info_url isnt a url' do
    @feed.more_info_url = "not a url"
    assert !@feed.valid?
  end

  test 'will be valid when more_info_url is a url' do
    @feed.more_info_url = "http://somewhere.com/path/to/info"
    assert @feed.valid?
  end

  test 'will be valid when more_info_url is nil' do
    @feed.more_info_url = nil
    assert @feed.valid?
  end

end
