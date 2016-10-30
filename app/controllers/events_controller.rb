class EventsController < ApplicationController
  def index
    @events = Event.all
    if params[:search]
      @events = Event.where('name LIKE ?', "%#{params[:search]}%")
    end
  end

  def show
    @event = Event.find(params[:id])
  end
end
