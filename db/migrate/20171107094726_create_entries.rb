# === entriesテーブル作成用マイグレーションファイル
class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.date :entry_date, null: false       # 日付
      t.string :note, limit: 40             # 摘要
      t.integer :supplier_id, null: false   # 取引先ID
      t.timestamps
    end
  end
end
