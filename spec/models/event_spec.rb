require 'rails_helper'

RSpec.describe Event, type: :model do

  describe ".upcoming" do
    it "should return empty when no event is created" do
      expect(Event.upcoming).to eq []
    end

    it "should return upcoming events only" do
      category1 = Category.create(name: "Entertainment")
      region1 = Region.create(name: "Ho Chi Minh")
      venue1 = Venue.create(name: "Venue 1", region: region1)

      event1 = Event.create!(name: "Event 1", starts_at: Time.now + 10000000, venue: venue1, category: category1, extended_html_description: "This is event 1")
      event2 = Event.create!(name: "Event 2", starts_at: Time.now - 10000000, venue: venue1, category: category1, extended_html_description: "This is event 2")
      event3 = Event.create!(name: "Event 3", starts_at: Time.now + 20000000, venue: venue1, category: category1, extended_html_description: "This is event 3")

      expect(Category.count).to eq 1
      expect(Region.count).to eq 1
      expect(Venue.count).to eq 1
      expect(Event.count).to eq 3
      expect(Event.upcoming).to match_array [event1, event3]
    end
  end

end
