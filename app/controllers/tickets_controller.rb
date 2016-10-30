class TicketsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @event = Event.find(params[:event_id])
  end
end
