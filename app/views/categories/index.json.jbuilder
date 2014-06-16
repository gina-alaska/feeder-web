json.array!(@categories) do |category|
  json.extract! category, :id, :name, :slug
  json.url category_url(category)
  json.feeds category.feeds, partial: 'feeds/feed', as: :feed
end
