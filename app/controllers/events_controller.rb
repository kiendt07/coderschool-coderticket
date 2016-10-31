class EventsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :mine, :create]
  def index
    @events = Event.published
    if params[:search]
      @events = Event.where('name LIKE ?', "%#{params[:search]}%")
    end
  end

  def show
    query = Event.find(params[:id])
    @event = query if query.published?
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params
    if @event.save
      flash[:success] = 'Create event successfuly'
      redirect_to events_path
    else
      flash.now[:notice] = 'Failed'
      redirect_to new_event_path(@event)
    end
  end

  def mine
    @events = Event.where('user_id = ?', current_user.id)
  end

  def publish
    @event = Event.find(params[:id])
    @event.published_at ||= Time.now
    if @event.save
      flash[:success] = 'Published successfully'
      redirect_to events_path
    else
      flash.now[:notice] = 'Published failed'
      redirect_to mine_events_path
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :name, :starts_at, :ends_at, :venue_id,
      :category_id, :hero_image_url,
      :extended_html_description
    )
  end
end
