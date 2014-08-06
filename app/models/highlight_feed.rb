class HighlightFeed < Feed
  include CustomModelNaming
  self.param_key = :feed
  self.route_key = :feeds
   
  def preview_entry
    entries.first
  end 
   
  def entries
    Entry.highlighted
  end
end
