class SlideshowFeed < ActiveRecord::Base
  belongs_to :slideshow
  belongs_to :feed
end
