class ReceiptsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @receipts = current_user.receipts
  end

  def new
    @event = Event.find(params[:event_id])
    @receipts = @event.ticket_types.map { |ticket_type| Receipt.new user: current_user, ticket_type: ticket_type}
  end

  def create
    @event = Event.find(params[:event_id])
    @receipts = @event.ticket_types.map.with_index { |ticket_type, i| Receipt.new user: current_user, ticket_type: ticket_type, quantity: params[:quantity][i]}
    @receipts.each do |r|
      if available_quantity?(r) && r.save

      else
        redirect_to event_tickets_path(@event), flash: {error: 'cannot book'}
      end
    end
    flash[:success] = 'Booked successfully'
    redirect_to receipts_path
  end

  private

  def receipt_params
    params.require(:receipt).permit(:user_id, :ticket_type_id, :quantity)
  end

  def quantity_params
    params[:quantity]
  end

  def available_quantity?(r)
    r.quantity <= 10
  end
end
