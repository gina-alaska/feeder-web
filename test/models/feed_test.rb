require 'test_helper'

describe Feed do
  let(:feed){feeds(:barrow_webcam)}

  it 'is valid with valid parameters' do
    feed.must_be :valid?, "Unable to create Feed with valid params"
  end

  it 'is invalid without a title' do
    feed.title = nil
    feed.wont_be :valid?
  end

  it('has_many entries') do
    Feed.reflect_on_association(:entries).macro.must_equal :has_many, "Feed does not have many entries"
  end

  it('generates the correct preview url') do
    feed.preview.must_equal entries(:entry_one), "Used the wrong entry for the preview url"
  end

  it('belongs_to category') do
    f = Feed.reflect_on_association(:category)
    f.macro.must_equal :belongs_to, "Feed does not belong to category"
  end

  it('is online when status is online') do
    f = Feed.new(status: 'online')
    f.online?.must_equal true
  end

  it('is offline when status isnt online') do
    f = Feed.new(status: 'not online')
    f.online?.must_equal false
  end

  it('will be invalid when more_info_url isnt a url') do
    feed.more_info_url = "not a url"
    feed.valid?.must_equal false
  end

  it('will be valid when more_info_url is a url') do
    feed.more_info_url = "http://somewhere.com/path/to/info"
    feed.valid?.must_equal true
  end

  it('will be valid when more_info_url is nil') do
    feed.more_info_url = nil
    feed.valid?.must_equal true
  end

end
