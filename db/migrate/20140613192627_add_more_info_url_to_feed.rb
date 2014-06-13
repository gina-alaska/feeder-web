class AddMoreInfoUrlToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :more_info_url, :string
  end
end
