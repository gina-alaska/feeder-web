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

  aasm do
    state :waiting, :initial => true
    state :available

    event :finish, before: :generate_uid do
      transitions :from => :waiting, :to => :available
    end
  end

  extend Dragonfly::Model
  dragonfly_accessor :image do
    copy_to(:image) do |i|
      if i.format == :tif
        i.process(:layer, 1, :jpg)
      else
        i.encode(:jpg)
      end
    end
    copy_to(:preview){|i| i.thumb('5000x5000>')}
  end
  dragonfly_accessor :preview

  def starred?(user)
    self.stars.where(user: user).any?
  end

  private
  def generate_uid
    self.uid = "#{event_at.to_i}#{id % 1000}".to_i if uid.nil?
  end
end
