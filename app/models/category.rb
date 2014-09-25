class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, allow_blank: false

  has_many :feeds
  
  def to_s
    name
  end
end
