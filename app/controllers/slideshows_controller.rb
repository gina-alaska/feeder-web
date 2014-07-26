class SlideshowsController < ApplicationController
  before_action :set_slideshow, only: [:show, :edit, :update, :destroy, :add, :remove, :carousel]
  before_action :set_device_type
  
  load_and_authorize_resource

  def set_device_type
    if browser.mobile? or browser.tablet?
      request.variant = :phone 
    end
  end

  # GET /slideshows
  # GET /slideshows.json
  def index
    @slideshows = Slideshow.order(title: :asc)
  end

  def add
    @feed = Feed.friendly.find(params[:feed_id])
    @slideshow.feeds << @feed unless @slideshow.feeds.include?(@feed)
    
    msg = "Added #{@feed} to slideshow"
    respond_to do |format|
      format.html {
        flash[:notice] = msg
        redirect_to @slideshow
      }
      format.js {
        flash.now[:notice] = msg
        redirect_via_turbolinks_to @slideshow
      }
    end
  end
  
  def remove
    @feed = Feed.friendly.find(params[:feed_id])
    @slideshow.feeds.destroy(@feed)
    msg = "Removed #{@feed} from slideshow"
    respond_to do |format|
      format.html {
        flash[:notice] = msg
        redirect_to @slideshow
      }
      format.js {
        flash.now[:notice] = msg
        redirect_via_turbolinks_to @slideshow
      }
    end
  end
  
  def carousel
    @entries = @slideshow.entries.recent.limit(12)
    
    respond_to do |format|
      format.html
      format.html.phone {
        render layout: 'mobile'
      }
    end
  end

  # GET /slideshows/1
  # GET /slideshows/1.json
  def show
    @entries = @slideshow.entries.recent.limit(12)
    
    @active_feeds = @slideshow.feeds.order(title: :asc)
    @available_feeds = Feed.where.not(id: @slideshow.feed_ids).order(title: :asc)
  end

  # GET /slideshows/new
  def new
    @slideshow = Slideshow.new
  end

  # GET /slideshows/1/edit
  def edit
  end

  # POST /slideshows
  # POST /slideshows.json
  def create
    @slideshow = Slideshow.new(slideshow_params)

    respond_to do |format|
      if @slideshow.save
        format.html { redirect_to @slideshow, notice: 'Slideshow was successfully created.' }
        format.json { render :show, status: :created, location: @slideshow }
      else
        format.html { render :new }
        format.json { render json: @slideshow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slideshows/1
  # PATCH/PUT /slideshows/1.json
  def update
    respond_to do |format|
      if @slideshow.update(slideshow_params)
        format.html { redirect_to @slideshow, notice: 'Slideshow was successfully updated.' }
        format.json { render :show, status: :ok, location: @slideshow }
      else
        format.html { render :edit }
        format.json { render json: @slideshow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slideshows/1
  # DELETE /slideshows/1.json
  def destroy
    @slideshow.destroy
    respond_to do |format|
      format.html { redirect_to slideshows_url, notice: 'Slideshow was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  protected
  
    # Use callbacks to share common setup or constraints between actions.
    def set_slideshow
      @slideshow = Slideshow.find_by_uid(params[:id].downcase)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slideshow_params
      params.require(:slideshow).permit(:title, :highlights_only)
    end
end
