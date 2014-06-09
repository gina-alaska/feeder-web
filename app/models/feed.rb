class Feed < ActiveRecord::Base
  validates :title, presence: true

end
