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
end
