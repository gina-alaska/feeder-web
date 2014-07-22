class CreateSlideshowFeeds < ActiveRecord::Migration
  def change
    create_table :slideshow_feeds do |t|
      t.references :feed
      t.references :slideshow

      t.timestamps
    end
  end
end
