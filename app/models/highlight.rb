class Highlight < ActiveRecord::Base
  belongs_to :user
  has_one :entry
  
  validates :description, presence: true, length: { in: 6..140 }
  
  def to_s
    self.description
  end
end
