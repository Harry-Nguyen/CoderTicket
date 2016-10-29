class User < ApplicationRecord
  has_many :events
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :name, presence: true, length: {minimum: 3, message: "is too short."}
  has_secure_password

  def myEvents
    Event.where(user_id: id)
  end
end
