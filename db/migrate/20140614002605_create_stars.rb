class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.integer :entry_id
      t.integer :user_id

      t.timestamps
    end
  end
end
