class Feed < ActiveRecord::Base
  validates :title, presence: true

  has_many :entries
end
