json.array!(@entries) do |entry|
  json.extract! entry, :id, :slug
  json.url feed_entry_url(entry.feed, entry)
  json.preview_url File.join(entry.helpers.root_url, entry.preview.url)
end
