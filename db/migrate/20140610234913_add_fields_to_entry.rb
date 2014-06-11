class AddFieldsToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :source_url, :string
    add_column :entries, :slug, :string
  end
end
