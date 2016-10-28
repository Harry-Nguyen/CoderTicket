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
