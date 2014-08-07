json.array! @feeds do |feed|
  unless feed.entries.empty?
    json.partial! 'feeds/feed', feed: feed
  end
end
