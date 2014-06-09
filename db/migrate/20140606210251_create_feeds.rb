class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :slug
      t.string :title
      t.text :description
      t.string :author
      t.string :status
      t.string :author
      t.string :location

      t.timestamps
    end
    add_index :feeds, :slug, unique: true
  end
end
