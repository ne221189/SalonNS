class CreateStylists < ActiveRecord::Migration[7.0]
  def change
    create_table :stylists do |t|
      t.references :salon, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
