class AddUserIdAndPublishedAtToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :user_id, :integer
    add_column :events, :published_at, :datetime
  end
end
