class EntriesController < ApplicationController
  MAX_ENTRIES = 100

  before_action :set_entry, only: [:show]
  before_action :set_feed
  after_action :set_page_headers, only: [:index]
  skip_before_action :verify_authenticity_token, only: [:create]

  # GET /entries
  # GET /entries.json
  def index
    @entries = @feed.entries.available.order(uid: :desc).limit(entries_limit)
    @entries = @entries.where('uid < ?', params[:max_id]) unless params[:max_id].nil?
    @entries = @entries.where('uid > ?', params[:since_id]) unless params[:since_id].nil?
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # POST /entries
  # POST /entries.json
  def create
    if params[:type] == "create"
      entry = Entry.new(entry_params)
      if entry.save
        FetchEntryWorker.perform_async(entry.id)
      end
    end
    render json: {success: true}, status: 200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.friendly.find(params[:id])
    end

    def set_feed
      @feed = Feed.friendly.find(params[:feed_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      payload = JSON.parse(params[:payload])
      {
        feed: Feed.friendly.find(params[:feed_id]),
        source_url: payload['data_url'],
        event_at: payload['event_date']
        # title: params[:entry][:event_date]
      }
    end

    def entries_limit
      [MAX_ENTRIES, (params[:count] || 10).to_i].min
    end

    def set_page_headers
      header_params = {count: entries_limit}
      header_params[:max_id] = @entries.last.uid if @entries.any?
      response.headers['X-Previous-Entries'] = feed_entries_url(@feed, header_params)
    end

end
