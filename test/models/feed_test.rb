require 'test_helper'

describe Feed do
  let(:feed){feeds(:one)}

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
    feed.preview.must_equal entries(:two), "Used the wrong entry for the preview url"
  end
end
