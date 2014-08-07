class HighlightFeed < Feed
  include CustomModelNaming
  self.param_key = :feed
  self.route_key = :feeds
   
  def preview_entry
    entries.order(event_at: :desc).first
  end 
   
  def entries
    Entry.highlighted
  end
end
