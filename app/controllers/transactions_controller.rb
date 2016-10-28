class TransactionsController < ApplicationController
  def show
    @transaction = Transaction.find(params[:id])
  end

  def create
    tickets = params[:quantity]

    ticketType = []
    quantities = []
    cost = 0
    event_id = 0

    tickets.each do |type, quantity|
      if (quantity.to_i > 0)
        ticketType += [type]
        quantities += [quantity]

        ticket = TicketType.find(type)
        event_id = ticket.event_id

        if (quantity.to_i > ticket.max_quantity)
          flash[:error] = 'Not enough ticket ' + ticket.name + ' for you to buy'
          redirect_to new_event_ticket_path(event_id) and return
        end

        if (quantity.to_i > 10)
          flash[:error] = 'You can buy up to 10 tickets/type/transaction only'
          redirect_to new_event_ticket_path(event_id) and return
        end

        cost += ticket.price * quantity.to_i
      end
    end

    ticketType = ticketType.join(',')
    quantities = quantities.join(',')
    transaction = Transaction.new(:email => params[:email], :ticketTypes => ticketType, :quantities => quantities, :cost => cost)
    if transaction.save
      flash[:success] = 'Tickets has been bought successfully'
      redirect_to transaction_path(transaction)
    else
      redirect_to new_event_ticket_path(event_id)
    end
  end
end
