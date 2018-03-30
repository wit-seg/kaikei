# === itemsテーブル作成用マイグレーションファイル
class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :code, limit: 10, null: false        # 勘定科目コード
      t.string :name, limit: 40, null: false        # 勘定科目名
      t.string :short_name, limit: 20, null: false  # 勘定科目略名
      t.timestamps
    end
  end
end
