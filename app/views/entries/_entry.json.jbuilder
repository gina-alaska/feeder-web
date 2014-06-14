json.extract! entry, :id, :slug
json.source_url feed_entry_url(entry.feed, entry)
json.data_url File.join(entry.helpers.root_url, entry.image.remote_url)
json.preview_url File.join(entry.helpers.root_url, entry.preview.url)
