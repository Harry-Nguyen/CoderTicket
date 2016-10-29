class Venue < ActiveRecord::Base
  belongs_to :region
  validates_uniqueness_of :name

  def eventHere?
    Event.where(venue_id: id)
  end
end
