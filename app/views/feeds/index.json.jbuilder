json.array!(@feeds) do |feed|
  json.extract! feed, :id, :title, :slug, :description, :updated_at, :mobile_compatible
  json.online feed.online?
  json.category feed.category.name
  json.preview_url File.join(feed.helpers.root_url, feed.preview.preview.url)
  json.entries_url feed_entries_url(feed, format: :json)
  json.more_info_url feed_more_info_url(feed)
end
