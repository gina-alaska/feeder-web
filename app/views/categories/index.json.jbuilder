json.array!(@categories) do |category|
  json.extract! category, :id, :name, :slug
  json.feeds category.feeds, partial: 'feeds/feed', as: :feed
end
