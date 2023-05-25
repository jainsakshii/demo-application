class AddUserIdToTheatre < ActiveRecord::Migration[6.1]
  def change
    add_column :theatres, :user_id, :integer
  end
end
