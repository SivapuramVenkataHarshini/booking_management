class CreateSeats < ActiveRecord::Migration[8.1]
  def change
    create_table :seats do |t|
      t.integer :seat_no
      t.boolean :booked

      t.timestamps
    end
  end
end
