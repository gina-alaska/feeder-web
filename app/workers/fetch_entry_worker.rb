class FetchEntryWorker
  include Sidekiq::Worker

  def perform(entry_id)
    e = Entry.find(entry_id)

    uid = Dragonfly.app.fetch_url(e.source_url).store
    e.image = Dragonfly.app.fetch(uid)
    e.save
    return false if e.image.nil?
    e.finish!
  end
end
