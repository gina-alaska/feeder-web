class Feed < ActiveRecord::Base
  include RouteHelpers

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true
  validates :more_info_url, :format => URI::regexp(%w(http https)), allow_blank: true

  has_many :entries
  belongs_to :category

  def preview
    entries.recent.first
  end

  def online?
    self.status == 'online'
  end
  
  def to_s
    title
  end
end
