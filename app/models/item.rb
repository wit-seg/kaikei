# = Itemモデル
# 勘定科目マスタを操作するためのモデル
class Item < ApplicationRecord
  # === バリデーション設定
  validates :code, :name, :short_name, presence: true
  validates :code, length: { maximum: 10 }
  validates :name, length: { maximum: 40 }
  validates :short_name, length: { maximum: 20 }
end
