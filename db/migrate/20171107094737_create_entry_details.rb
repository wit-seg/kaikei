# === entry_detailsテーブル作成用マイグレーションファイル
class CreateEntryDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :entry_details do |t|
      t.integer :entry_id, null: false              # 仕訳ID
      t.integer :kind, null: false                  # 貸借区分
      t.string :item_code, limit: 10, null: false   # 借方勘定科目コード
      t.integer :money, null: false                 # 借方金額

      t.timestamps
    end
  end
end
