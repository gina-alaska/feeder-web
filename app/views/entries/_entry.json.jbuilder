json.extract! entry, :id, :slug
json.url feed_entry_url(entry.feed, entry)
# json.source_url entry.source_url
json.data_url File.join(entry.helpers.root_url, entry.image.remote_url)
json.preview_url File.join(entry.helpers.root_url, entry.preview.url)
json.starred entry.starred?(current_user)
