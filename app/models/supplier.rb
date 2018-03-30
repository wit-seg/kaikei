# = Supplierモデル
# 取引先マスタを操作するためのモデル
class Supplier < ApplicationRecord
  # === バリデーション設定
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
end
