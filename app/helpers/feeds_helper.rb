module FeedsHelper
  def feeds_like(source)
    if source.is_a? Feed
      Feed.order(title: :asc)
    elsif source.is_a? Slideshow
      Slideshow.order(title: :asc)
    end
  end
end
