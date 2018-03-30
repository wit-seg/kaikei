# === suppliersテーブル作成用マイグレーションファイル
class CreateSuppliers < ActiveRecord::Migration[5.1]
  def change
    create_table :suppliers do |t|
      t.string :name, limit: 30, null: false  # 取引先名
      t.timestamps
    end
  end
end
