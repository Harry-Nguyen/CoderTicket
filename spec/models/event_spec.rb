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

  describe ".have_enough_ticket_types?" do
    it "should return false when there is no ticket type" do
      category1 = Category.create(name: "Entertainment")
      region1 = Region.create(name: "Ho Chi Minh")
      venue1 = Venue.create(name: "Venue 1", region: region1)
      event1 = Event.create!(name: "Event 1", starts_at: Time.now + 10000000, venue: venue1, category: category1, extended_html_description: "This is event 1")

      expect(event1.have_enough_ticket_types?).to eq false
    end

    it "should return true when there is at least 1 ticket type" do
      category1 = Category.create(name: "Entertainment")
      region1 = Region.create(name: "Ho Chi Minh")
      venue1 = Venue.create(name: "Venue 1", region: region1)
      event1 = Event.create!(name: "Event 1", starts_at: Time.now + 10000000, venue: venue1, category: category1, extended_html_description: "This is event 1")
      type1 = TicketType.create!(event: event1, price: 50000, name: "Standard", max_quantity: 50)

      expect(event1.have_enough_ticket_types?).to eq true
    end
  end

  describe ".ticketTypes" do
    it "return empty when there is not ticket type" do
      category1 = Category.create(name: "Entertainment")
      region1 = Region.create(name: "Ho Chi Minh")
      venue1 = Venue.create(name: "Venue 1", region: region1)
      event1 = Event.create!(name: "Event 1", starts_at: Time.now + 10000000, venue: venue1, category: category1, extended_html_description: "This is event 1")

      expect(event1.ticketTypes).to eq []
    end

    it "should return ticketTypes in this venue" do
      category1 = Category.create(name: "Entertainment")
      region1 = Region.create(name: "Ho Chi Minh")
      venue1 = Venue.create(name: "Venue 1", region: region1)
      event1 = Event.create!(name: "Event 1", starts_at: Time.now + 10000000, venue: venue1, category: category1, extended_html_description: "This is event 1")
      type1 = TicketType.create!(event: event1, price: 50000, name: "Standard", max_quantity: 50)
      type2 = TicketType.create!(event: event1, price: 100000, name: "VIP", max_quantity: 50)

      expect(event1.ticketTypes).to match_array [type1, type2]
    end
  end
end