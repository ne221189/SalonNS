class CreateShifts < ActiveRecord::Migration[7.0]
  def change
    create_table :shifts do |t|
      t.references :stylist #, null:false
      t.references :reservation
      t.datetime :date_time, null:false

      t.timestamps
    end
  end
end
