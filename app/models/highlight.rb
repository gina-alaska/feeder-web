class Highlight < ActiveRecord::Base
  belongs_to :user
  has_one :entry
  
  def to_s
    self.description
  end
end
