class EntriesController < ApplicationController
  MAX_ENTRIES = 100

  before_action :set_entry, only: [:show]
  before_action :set_feed
  skip_before_action :verify_authenticity_token, only: [:create]

  # GET /entries
  # GET /entries.json
  def index
    @entries = @feed.entries.available.order(uid: :desc).limit(entries_limit)
    @entries = @entries.where('uid < ?', params[:max_id]) unless params[:max_id].nil?
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
      {
        feed: Feed.friendly.find(params[:feed_id]),
        source_url: params[:payload][:data_url],
        event_at: params[:payload][:event_date]
        # title: params[:entry][:event_date]
      }
    end

    def entries_limit
      [MAX_ENTRIES, (params[:count] || 10).to_i].min
    end
end
