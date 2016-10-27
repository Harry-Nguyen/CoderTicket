require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "load upcoming events only" do
      category1 = Category.create(name: "Entertainment")
      region1 = Region.create(name: "Ho Chi Minh")
      venue1 = Venue.create(name: "Venue 1", region: region1)

      event1 = Event.create!(name: "Event 1", starts_at: Time.now + 10000000, venue: venue1, category: category1, extended_html_description: "This is event 1")
      event2 = Event.create!(name: "Event 2", starts_at: Time.now - 10000000, venue: venue1, category: category1, extended_html_description: "This is event 2")
      event3 = Event.create!(name: "Event 3", starts_at: Time.now + 20000000, venue: venue1, category: category1, extended_html_description: "This is event 3")

      get :index

      expect(assigns(:events)).to match_array([event1, event3])
    end
  end
end
