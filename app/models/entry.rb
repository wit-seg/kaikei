# = Entryモデル
# 仕訳データを操作するためのモデル
class Entry < ApplicationRecord
  # === 貸借区分
  # * 1: 借方
  # * 2: 貸方
  KIND = {
    DEBIT: 1,   # 借方
    CREDIT: 2   # 貸方
  }

  # === アソシエーション設定
  has_many :entry_details, dependent: :destroy
  has_many :debit_details, -> { where(kind: KIND[:DEBIT]).includes(:item).references(:item) }, dependent: :destroy, class_name: 'EntryDetail', inverse_of: :entry
  has_many :credit_details, -> { where(kind: KIND[:CREDIT]).includes(:item).references(:item) }, dependent: :destroy, class_name: 'EntryDetail', inverse_of: :entry
  belongs_to :supplier

  accepts_nested_attributes_for :debit_details, allow_destroy: true
  accepts_nested_attributes_for :credit_details, allow_destroy: true

  # === バリデーション設定
  validates :entry_date, presence: true
  validates :note, length: { maximum: 40 }
end
