class Slideshow < ActiveRecord::Base
  has_many :slideshow_feeds
  has_many :feeds, through: :slideshow_feeds
end
