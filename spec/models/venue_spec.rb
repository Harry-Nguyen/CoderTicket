require 'rails_helper'

RSpec.describe Venue, type: :model do
  describe ".eventHere?" do
    it "return empty when there is no event in this venue" do
      category1 = Category.create(name: "Entertainment")
      region1 = Region.create(name: "Ho Chi Minh")
      venue1 = Venue.create(name: "Venue 1", region: region1)
      venue2 = Venue.create(name: "Venue 2", region: region1)
      event1 = Event.create!(name: "Event 1", venue: venue2, user_id: 1, starts_at: Time.now + 10000000, category: category1, extended_html_description: "This is event 1")

      expect(venue1.eventHere?).to eq []
    end

    it "return events that is hosted here" do
      category1 = Category.create(name: "Entertainment")
      region1 = Region.create(name: "Ho Chi Minh")
      venue1 = Venue.create(name: "Venue 1", region: region1)
      venue2 = Venue.create(name: "Venue 2", region: region1)
      event1 = Event.create!(name: "Event 1", venue: venue2, user_id: 1, starts_at: Time.now + 10000000, category: category1, extended_html_description: "This is event 1")
      event2 = Event.create!(name: "Event 2", venue: venue1, user_id: 2, starts_at: Time.now - 10000000, category: category1, extended_html_description: "This is event 2")
      event3 = Event.create!(name: "Event 3", venue: venue1, user_id: 1, starts_at: Time.now + 20000000, category: category1, extended_html_description: "This is event 3")

      expect(venue1.eventHere?).to match [event2, event3]
    end
  end
end