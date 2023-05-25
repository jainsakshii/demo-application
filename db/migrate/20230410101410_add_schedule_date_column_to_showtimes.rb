class AddScheduleDateColumnToShowtimes < ActiveRecord::Migration[6.1]
  def change
    add_column :showtimes, :scheduleDate, :date
  end
end
