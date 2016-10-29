require 'rails_helper'

RSpec.describe User, type: :model do
  describe ".myEvents" do
    it "return empty when I haven't created any event" do
      category1 = Category.create(name: "Entertainment")
      region1 = Region.create(name: "Ho Chi Minh")
      venue1 = Venue.create(name: "Venue 1", region: region1)
      event1 = Event.create!(name: "Event 1", user_id: 2, starts_at: Time.now + 10000000, venue: venue1, category: category1, extended_html_description: "This is event 1")
      user = User.create(name: "Jackson", email: "a@a.com", password: "1234")

      expect(user.myEvents.count).to eq 0
    end

    it "return events that I created" do
      category1 = Category.create(name: "Entertainment")
      region1 = Region.create(name: "Ho Chi Minh")
      venue1 = Venue.create(name: "Venue 1", region: region1)
      user1 = User.create(name: "Jackson", email: "a@a.com", password: "1234")
      user2 = User.create(name: "Henry", email: "b@b.com", password: "1234")
      event1 = Event.create!(name: "Event 1", user: user1, starts_at: Time.now + 10000000, venue: venue1, category: category1, extended_html_description: "This is event 1")
      event2 = Event.create!(name: "Event 2", user: user2, starts_at: Time.now - 10000000, venue: venue1, category: category1, extended_html_description: "This is event 2")
      event3 = Event.create!(name: "Event 3", user: user1, starts_at: Time.now + 20000000, venue: venue1, category: category1, extended_html_description: "This is event 3")

      expect(user1.myEvents).to match_array [event1, event3]
    end
  end
end
