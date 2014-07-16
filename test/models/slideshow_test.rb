require 'test_helper'

class SlideshowTest < ActiveSupport::TestCase
  let(:slideshow){ slideshows(:barrow) }
  # test "the truth" do
  #   assert true
  # end
  
  test 'should have many feeds' do
    s = Slideshow.reflect_on_association(:feeds)
    s.macro.must_equal :has_many, "Slideshow does not have many feeds"
  end
  
  test 'should not be valid without a title' do
    slideshow.title = nil
    assert_not slideshow.valid?
  end
  
  test 'should generate uids' do
    s = Slideshow.create(title: slideshow.title)

    assert s.save
    assert_not_nil s.uid
  end
  
  test 'should return multiple feeds' do
    assert slideshow.feeds.count > 0, 'slideshow did not return any feeds'
  end
  
  test 'should generate uid of length 6' do
    assert Slideshow.generate_uid.length == 6
  end
  
  test 'should not change uid on update' do
    uid = slideshow.uid
    slideshow.save
    assert uid == slideshow.uid
  end
end
