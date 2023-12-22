class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.integer :required_time

      t.timestamps
    end
  end
end
