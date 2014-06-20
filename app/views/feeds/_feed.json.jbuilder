json.extract! feed, :id, :title, :slug, :description, :updated_at, :mobile_compatible
json.url feed_url(feed)
json.online feed.online?
json.category feed.category.name
json.preview_url entry_preview_url(feed.preview.preview_uid)
json.entries_url feed_entries_url(feed)
json.more_info_url feed_more_info_url(feed)
