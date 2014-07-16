class Slideshow < ActiveRecord::Base
  has_many :slideshow_feeds
  has_many :feeds, through: :slideshow_feeds
  has_many :entries, through: :feeds
  
  validates :title, presence: true
  validates :uid, uniqueness: true
  
  before_create :set_unique_uid
  
  accepts_nested_attributes_for :slideshow_feeds
  accepts_nested_attributes_for :feeds
  
  
  def self.generate_uid
    SecureRandom.hex(3)
  end
  
  def set_unique_uid
    while(self.uid.nil? or Slideshow.where(uid: self.uid).count > 0) do
      self.uid = Slideshow.generate_uid
    end
  end
  
  def to_param
    self.uid
  end
  
  def to_s
    self.title
  end
end
