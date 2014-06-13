class AddMobileCompatibleToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :mobile_compatible, :boolean, default: true
  end
end
