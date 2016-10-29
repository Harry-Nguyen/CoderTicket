class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  belongs_to :user
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def self.upcoming
    Event.where("starts_at > ?", Time.now)
  end

  def have_enough_ticket_types?
    TicketType.where(event_id: id).count > 0
  end

  def ticketTypes
    TicketType.where(event_id: id)
  end
end
