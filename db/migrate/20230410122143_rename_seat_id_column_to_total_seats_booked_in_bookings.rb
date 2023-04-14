class RenameSeatIdColumnToTotalSeatsBookedInBookings < ActiveRecord::Migration[6.1]
  def up
    add_column :bookings, :total_seats_booked, :integer
  end

  def down
    remove_column :bookings, :seat_id
  end
end
