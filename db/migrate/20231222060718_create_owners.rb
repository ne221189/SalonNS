class CreateOwners < ActiveRecord::Migration[7.0]
  def change
    create_table :owners do |t|
      t.references :salon, null: false
      t.string :name, null: false # 名前
      t.string :email # メールアドレス
      t.string :phone, null: false # 電話番号
      t.integer :sex, null: false, default: 1 # 性別 (1:男, 2:女)
      t.date :birthday, null: false, default: -> { '(CURRENT_DATE)' } # 生年月日

      t.timestamps
    end
  end
end
