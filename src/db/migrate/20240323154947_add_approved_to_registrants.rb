class AddApprovedToRegistrants < ActiveRecord::Migration[6.0]
  def change
    add_column :registrants, :approved, :boolean, default: false
  end
end
