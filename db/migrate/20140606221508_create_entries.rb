class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :feed_id
      t.string :title
      t.string :location
      t.datetime :event_at
      t.string :image_uid
      t.string :image_name
      t.string :preview_uid
      t.string :preview_name

      t.timestamps
    end
  end
end
