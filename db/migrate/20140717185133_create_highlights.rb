class CreateHighlights < ActiveRecord::Migration
  def change
    create_table :highlights do |t|
      t.integer :user_id
      t.text :description

      t.timestamps
    end
    
    add_column :entries, :highlight_id, :integer
  end
end
