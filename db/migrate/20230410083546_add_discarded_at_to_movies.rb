class AddDiscardedAtToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :discarded_at, :datetime
    add_index :movies, :discarded_at
  end
end
