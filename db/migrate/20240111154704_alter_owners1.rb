class AlterOwners1 < ActiveRecord::Migration[7.0]
    def change
        # パスワードのハッシュ値を保存するカラム
        add_column :owners, :password_digest, :string
    end
end
