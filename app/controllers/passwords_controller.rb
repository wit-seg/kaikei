# = Passwordsコントローラ
class PasswordsController < ApplicationController
  before_action :set_user

  # === パスワード変更画面を表示
  def edit
  end

  # === パスワード更新処理
  def update
    if @user.update_attributes(user_params)
      redirect_to root_path, notice: "パスワードを更新しました"
    else
      render :edit
    end
  end

  private

  # === ユーザオブジェクトをインスタンス変数にセット
  def set_user
    @user = User.first
  end

  # === パラメータ項目の許可処理
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
