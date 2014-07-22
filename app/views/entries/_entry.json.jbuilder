json.extract! entry, :id, :slug, :event_at, :uid
json.uid_str entry.uid.to_s
json.url entry_url(entry, :json)
json.feed_url feed_url(entry.feed, :json)
json.source_url entry.source_url
json.data_url File.join(entry.helpers.root_url, entry.image.remote_url)
json.preview_url entry_preview_url(entry.preview_uid)
json.highlighted entry.highlight.present?
json.highlight_description entry.highlight.try(:description)
