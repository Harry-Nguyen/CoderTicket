class TicketTypesController < ApplicationController
  def new
    @type = TicketType.new
  end

  def create
    type = TicketType.new(:event_id => params[:event_id], :price => params[:price], :name => params[:name], :max_quantity => params[:max_quantity])
    if type.save
      flash[:success] = 'Ticket type has been created successfully'
      redirect_to event_path(params[:event_id])
    else
      redirect_to new_event_ticket_type_path(params[:event_id])
    end
  end
end
