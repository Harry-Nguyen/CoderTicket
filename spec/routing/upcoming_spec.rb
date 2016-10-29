require 'rails_helper'

RSpec.describe "routing to upcoming", :type => :routing do
  it "routes /upcoming to events#index" do
    expect(:get => "/upcoming").to route_to(
      :controller => "events",
      :action => "index"
    )
  end

  it "routes /events/mine to events#mine" do
    expect(:get => "/events/mine").to route_to(
      :controller => "events",
      :action => "mine"
    )
  end
end