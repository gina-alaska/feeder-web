class AddHighlightsOnlyBoolToSlideshow < ActiveRecord::Migration
  def change
    add_column :slideshows, :highlights_only, :boolean, default: false
  end
end
