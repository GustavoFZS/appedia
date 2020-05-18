class AddUsersToThings < ActiveRecord::Migration[5.2]
  def change
    add_reference :things, :user, foreign_key: true
  end
end
