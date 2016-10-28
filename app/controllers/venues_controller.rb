class VenuesController < ApplicationController
  def index
    @venues = Venue.all
  end

  def show
    @venue = Venue.find(params[:id])
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new venue_params
    if @venue.save
      flash[:success] = 'venue is created successfully'
      redirect_to venue_path(@venue)
    else
      render 'new'
    end
  end

  private
  def venue_params
    params.require(:venue).permit(:name, :full_address, :region_id);
  end
end
