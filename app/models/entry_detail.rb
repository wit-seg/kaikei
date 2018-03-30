# = EntryDetailモデル
# 仕訳明細データを操作するためのモデル
class EntryDetail < ApplicationRecord
  # === アソシエーション設定
  belongs_to :entry, inverse_of: :entry_details
  belongs_to :item, primary_key: :code, foreign_key: :item_code

  # === バリデーション設定
  validates :money, presence: true
  validates :item_code, length: { maximum: 10 }
  validates :money, numericality: { only_integer: true }
end
