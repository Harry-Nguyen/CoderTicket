require 'rails_helper'

RSpec.describe "events/mine", :type => :view do
  it "renders card partial for events" do
    category1 = Category.create(name: "Entertainment")
    region1 = Region.create(name: "Ho Chi Minh")
    venue1 = Venue.create(name: "Venue 1", region: region1)
    event1 = Event.create!(name: "Event 1", user_id: 2, starts_at: Time.now + 10000000, venue: venue1, category: category1, extended_html_description: "This is event 1")
    event2 = Event.create!(name: "Event 2", user_id: 2, starts_at: Time.now - 10000000, venue: venue1, category: category1, extended_html_description: "This is event 2")

    assign(:events, [event1, event2])
    render
    expect(view).to render_template(:partial => "_card", :count => 2)
  end

  it "displays the event name" do
    category1 = Category.create(name: "Entertainment")
    region1 = Region.create(name: "Ho Chi Minh")
    venue1 = Venue.create(name: "Venue 1", region: region1)
    event1 = Event.create!(name: "Event 1", user_id: 2, starts_at: Time.now + 10000000, venue: venue1, category: category1, extended_html_description: "This is event 1")
    event2 = Event.create!(name: "Event 2", user_id: 2, starts_at: Time.now - 10000000, venue: venue1, category: category1, extended_html_description: "This is event 2")

    assign(:events, [event1, event2])
    render
    expect(rendered).to include("Event 1")
    expect(rendered).to include("Event 2")
  end
end