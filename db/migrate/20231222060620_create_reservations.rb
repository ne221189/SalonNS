class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :customer, null: false
      t.date :reserved_date, null:false
      t.integer :reserved_time, null:false
      t.integer :sum_price, null:false
      t.integer :course_id, null:false

      t.timestamps
    end
  end
end
