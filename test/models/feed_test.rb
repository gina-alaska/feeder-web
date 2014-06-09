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

  
end
