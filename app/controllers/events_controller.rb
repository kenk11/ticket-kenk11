class EventsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    if params[:keyword]
      # @events = Event.coming.search(params[:keyword])
      @events = Event.search(params[:keyword]).order(starts_at: :asc)
    else
      @events = Event.coming.order(starts_at: :asc)
    end
  end

  def list
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @type = Event.new
    @venues = Venue.all
    @categories = Category.all
  end

  def create
    @events = Event.new(event_params)
    @venues = Venue.all
    @categories = Category.all
    if @events.save
      flash[:success] = 'Created event successfully!'
      redirect_to root_path
    else
      flash[:error] = "Error: #{@events.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
    @venues = Venue.all
    @categories = Category.all
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:success] = 'Updated event successfully!'
      redirect_to list_path
    else
      flash[:error] = "Error: #{@type.errors.full_messages.to_sentence}"
      render 'edit'
    end
  end

  def destroy

  end

  private
  def event_params
    params.require(:event).permit(:name, :starts_at, :ends_at, :venue_id, :category_id, :hero_image_url, :extended_html_description)
  end
end
