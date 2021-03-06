class Entry < ActiveRecord::Base
  include AASM
  include RouteHelpers
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :source_url, :format => URI::regexp(%w(http https)), uniqueness: true
  validates :event_at, presence: true
  validates :uid, presence: true, uniqueness: true, allow_blank: true

  has_many :stars
  has_many :users, through: :stars

  belongs_to :feed
  belongs_to :highlight

  scope :recent, -> { available.order(uid: :desc) }
  scope :highlighted, -> { where.not(highlight: nil) }

  aasm do
    state :waiting, :initial => true
    state :available

    event :finish, before: :generate_uid do
      transitions :from => [:waiting, :available], :to => :available
    end
  end

  extend Dragonfly::Model
  dragonfly_accessor :image do
    copy_to(:image) do |i|
      if self.feed.category.name == 'Movie'
        i.convert("", 'format' => 'jpg', 'frame' => 1, 'delegate' => 'ffmpeg')
      else
        if i.format == 'tiff'
          i.convert("", 'format' => 'jpg', 'frame' => 1)
        else
          i.encode(:jpg)
        end
      end
    end
    copy_to(:preview){|i| i.thumb('5000x5000>')}
  end
  dragonfly_accessor :preview

  def starred?(user)
    self.stars.where(user: user).any?
  end
  
  def async_fetch
    FetchEntryWorker.perform_async(self.id)
  end

  def to_s
    event_at
  end

  private
  def generate_uid
    self.uid = "#{event_at.to_i}#{"%03i" % (id % 1000)}".to_i if uid.nil?
  end
end
