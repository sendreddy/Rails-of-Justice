class AddDeclinedReasonToRegistrants < ActiveRecord::Migration[6.0]
  def change
    add_column :registrants, :declinedReason, :string
  end
end
