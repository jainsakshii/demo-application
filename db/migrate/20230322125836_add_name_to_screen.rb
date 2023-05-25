class AddNameToScreen < ActiveRecord::Migration[6.1]
  def change
    add_column :screens, :name, :string
  end
end
