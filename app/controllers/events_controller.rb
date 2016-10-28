class EventsController < ApplicationController
  def index
    search = params[:search]

    @events = Event.upcoming

    if search
      @events.each do |e|
        if !e.name.include? search
          @events -= [e]
        end
      end
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def publish
    @event = Event.find(params[:id])
    
    if @event.user_id != session[:user_id]
      flash[:error] = 'Only creator can publish this event'
      redirect_to event_path(@event) and return
    end

    if @event.published_at
      flash[:success] = 'This event has been published before'
      redirect_to event_path(@event) and return
    end

    if !@event.have_enough_ticket_types?
      flash[:error] = 'At least one ticket type is needed before publishing this event.'
      redirect_to event_path(@event) and return
    end

    @event.published_at = DateTime.now
    
    if @event.save
      flash[:success] = 'This event has been published'
    end
    redirect_to event_path(@event)
  end

  def create
    params[:event][:user_id] = session[:user_id]
    params[:event][:starts_at] = DateTime.strptime(params[:event][:starts_at], '%d-%m-%Y %I:%M:%S %p')
    params[:event][:ends_at] = DateTime.strptime(params[:event][:ends_at], '%d-%m-%Y %I:%M:%S %p')
    params[:event][:published_at] = nil

    @event = Event.new event_params
    if @event.save
      flash[:success] = 'Event is created successfully'
      redirect_to event_path(@event)
    else
      render 'new'
    end
  end

  private
  def event_params
    params.require(:event).permit(:starts_at, :ends_at, :venue_id, :hero_image_url, :extended_html_description, :category_id, :name, :published_at, :user_id);
  end
end
