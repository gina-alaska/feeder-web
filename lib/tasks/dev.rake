namespace :dev do
  namespace :feeds do
    desc 'Seed the database with available feeds and latest imagery'
    task :create => :environment do
      feeder = URI.parse('http://feeder.gina.alaska.edu/feeds.json')
      feeds = JSON.parse(Net::HTTP.get_response(feeder).body)

      feeds.each do |feed|
        next unless feed['status'] == 'online'

        category = Category.where(name: 'Imagery').first
        
        # We don't have a new-feed-event spec yet, so just create it
        f = Feed.where(title: feed['title']).first_or_initialize

        if f.new_record?
          puts "Creating new feed: #{f.title}"
          f.update_attributes(
            category: category, 
            location: feed['where'],
            description: feed['description'],
            status: 'online',
            author: feed['author']
          )

          f.save
        end
        # TODO: This should be its own task, and executed after f.save
        puts "Fetching entries: #{feed['entries']}"
        entries_url = URI.parse(feed['entries'])
        entries = JSON.parse(Net::HTTP.get_response(entries_url).body)
        entries.each do |entry|
          # e = Entry.new(
          #   feed: f,
          #   source_url: entry['image'],
          #   title: entry['title'],
          #   event_at: entry['event_at']
          # )
          # if e.save
          #   FetchEntryWorker.perform_async(e.id)
          #Create an entry payload
          entry_hash = {
            'version' => '0.0.1-fake',
            'type' => 'create',
            'payload[data_url]' => entry['source'],
            'payload[event_date]' => entry['event_at'],
            #These two are incorrect, but aren't used.
            # Included for completeness
            'payload[event_url]' => entries_url.to_s,
            'payload[feed_url]' => feeder.to_s
          }
          Net::HTTP.post_form(URI.parse("http://192.168.0.57/feeds/#{f.slug}/entries.json"), entry_hash)
        end
      end
    end
    
    desc 'Seed movies'
    task :movies => :environment do
      category = Category.where(name: 'Movie').first
      feed = Feed.where(title: 'Barrow Webcam movie (1day)', category: category).first_or_initialize
      feed.save if feed.new_record?
      
      entry_hash = {
        version: '0.0.1-fake',
        type: 'create',
        'payload[data_url]' => 'http://feeder.gina.alaska.edu/dragonfly/movies/2014/7/28/3774_webcam-uaf-barrow-seaice-images_2014-7-28_1-day-animation.mp4',
        'payload[event_date]' => '2014-07-28T00:00:00Z',
        'payload[event_url]' => 'http://feeder.gina.alaska.edu/feeds/webcam-uaf-barrow-seaice-images/movies/3774_webcam-uaf-barrow-seaice-images_2014-7-28_1-day-animation',
        'payload[feed_url]' => 'http://feeder.gina.alaska.edu/feeds/webcam-uaf-barrow-seaice-images/movies'
      }
      
      Net::HTTP.post_form(URI.parse("http://192.168.0.57/feeds/#{feed.slug}/entries"), entry_hash)
    end
  end
  
  

  # namespace :entries do
  #   desc "Fetch the latest N entries for feeds"
  #   task :seed => :environment do
  #     Feed.all.each do |feed|
  #       feed.
  #       entries_url = URI.parse(feed['entries'])
  #       entries = JSON.parse(Net::HTTP.get_response(entries_url).body)
  #       entries.each do |entry|
  #         e = Entry.new(
  #           feed: f,
  #           source_url: entry['image'],
  #           title: entry['title'],
  #           event_at: entry['event_at']
  #         )
  #         if e.save
  #           FetchEntryWorker.perform_async(e.id)
  #         end
  #       end
  #     end
  #   end
  # end
end
