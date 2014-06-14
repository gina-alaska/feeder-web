class Entry < ActiveRecord::Base
  include RouteHelpers
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :stars
  has_many :users, through: :stars

  belongs_to :feed

  extend Dragonfly::Model
  dragonfly_accessor :image do
    copy_to(:image) do |i|
      if i.format == :tif
        i.process(:layer, 1, :jpg)
      else
        i.encode(:jpg)
      end
    end
    copy_to(:preview){|i| i.thumb('200x200')}
  end
  dragonfly_accessor :preview

  def starred?(user)
    self.stars.where(user: user).any?
  end
end
