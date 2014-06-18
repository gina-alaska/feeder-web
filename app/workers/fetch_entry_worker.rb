class FetchEntryWorker
  include Sidekiq::Worker

  def perform(entry_id)
    e = Entry.find(entry_id)

    e.image_url = e.source_url
    e.finish!
  end
end
