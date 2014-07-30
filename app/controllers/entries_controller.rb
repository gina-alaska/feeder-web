class EntriesController < ApplicationController
  MAX_ENTRIES = 100
  before_action :set_device_type
  before_action :set_entry, only: [:show]
  before_action :set_entries, only: [:index]
  after_action :set_page_headers, only: [:index]
  skip_before_action :verify_authenticity_token, only: [:create]

  respond_to :html, :json



  # GET /entries
  # GET /entries.json
  def index
    @paginated = false
    @entries = @entries.recent.order(uid: :desc)

    @source = @feed || @slideshow

    @calendar_date = Date.parse(params[:date]) if params[:date].present?
    @calendar_date ||= Time.zone.now

    if params[:slideshow_id].present?
      # slideshow
      @entries = @entries.limit(12)
    elsif params.include?(:max_id) or params.include?(:since_id)
      # continuous scrolling!
      @entries = @entries.where('uid < ?', params[:max_id]) if params[:max_id].present?
      @entries = @entries.where('uid > ?', params[:since_id]) if params[:since_id].present?
      @entries = @entries.limit(entries_limit)
    elsif params[:date].present?
      # calendar based viewing
      @paginated = true
      @entries = @entries.where(event_at: [@calendar_date.to_time.beginning_of_day..@calendar_date.to_time.end_of_day]).page(params[:page])
    else
      @paginated = true
      @entries = @entries.page(params[:page]).per(entries_limit)
    end

    respond_with @entries
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    respond_to do |format|
      format.html
      format.html.phone {
        render layout: 'mobile'
      }
      format.json
    end
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
      if params[:id].present?
        if params[:id] == 'current'
          @feed = Feed.friendly.find(params[:feed_id])
          @entry = @feed.entries.recent.first
        else
          @entry = Entry.friendly.find(params[:id])
        end
      end
    end

    def set_entries
      if params[:feed_id].present?
        @feed = Feed.friendly.find(params[:feed_id])
        @entries = @feed.entries
      elsif params[:slideshow_id].present?
        @slideshow = Slideshow.find_by_uid(params[:slideshow_id])
        @entries = @slideshow.entries
      end
    end

    def set_slideshow
      @slideshow = Slideshow.find_uid(params[:slideshow_id]) if params[:slideshow_id].present?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      payload = params.require(:payload).permit(:data_url, :event_date, :event_url, :feed_url)
      {
        feed: Feed.friendly.find(params[:feed_id]),
        source_url: payload['data_url'],
        event_at: payload['event_date']
        # title: params[:entry][:event_date]
      }
    end

    def entries_limit
      [MAX_ENTRIES, (params[:count] || 20).to_i].min
    end

    def set_page_headers
      header_params = {count: entries_limit}
      header_params[:max_id] = @entries.last.uid if @entries.any?
      if @feed.present?
        response.headers['X-Previous-Entries'] = feed_entries_url(@feed, header_params)
      elsif @slideshow.present?
        response.headers['X-Previous-Entries'] = slideshow_entries_url(@slideshow, header_params)
      end
    end
end
