# = Userモデル
# 本システムを利用するためのユーザ情報を管理するためのモデル
class User < ApplicationRecord
  # Authlogicを適用
  acts_as_authentic

  # === バリデーション設定
  validates :password, presence: true
end
