json.extract! entry, :id, :slug, :event_at, :uid
json.uid_str entry.uid.to_s
json.url feed_entry_url(entry.feed, entry)
json.source_url entry.source_url
json.data_url File.join(entry.helpers.root_url, entry.image.remote_url)
json.preview_url entry_preview_url(entry.preview_uid)
json.starred entry.starred?(current_user)
