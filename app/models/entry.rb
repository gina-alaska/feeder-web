class Entry < ActiveRecord::Base
  belongs_to :feed

  extend Dragonfly::Model
  dragonfly_accessor :image do
    copy_to(:image) do |i|
      i.gdal_translate('-scale -of PNG')
    end
    copy_to(:preview){|i| i.thumb('200x200')}
  end
  dragonfly_accessor :preview

end
