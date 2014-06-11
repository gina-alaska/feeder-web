class Entry < ActiveRecord::Base
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

end
