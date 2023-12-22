class CreateSalons < ActiveRecord::Migration[7.0]
  def change
    create_table :salons do |t|
      t.references :owner, null: false
      t.string :name, null: false
      t.string :prefecture, null: false
      t.string :adress, null: false

      t.timestamps
    end
  end
end
