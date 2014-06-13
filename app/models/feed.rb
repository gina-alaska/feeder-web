class Feed < ActiveRecord::Base
  include RouteHelpers

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true
  validates :more_info_url, :format => URI::regexp(%w(http https)), allow_blank: true

  has_many :entries
  belongs_to :category

  def preview
    entries.order(event_at: :desc).first
  end



  def online?
    self.status == 'online' ? true : false
  end
end
