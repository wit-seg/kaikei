# === usersテーブル作成用マイグレーションファイル
class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :login, limit: 20, null: false   # ログインID
      t.string :crypted_password                # 暗号化パスワード
      t.string :password_salt                   # Authlogic認証用ソルト
      t.string :persistence_token               # Authlogic認証用トークン文字列

      t.timestamps                              # 登録・更新日時
    end
  end
end
