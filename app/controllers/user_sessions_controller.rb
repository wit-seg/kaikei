# = UserSessionsコントローラ
class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  # === ログイン画面を表示
  # 空のセッション情報を生成してログイン画面を表示する
  def new
    @user_session = UserSession.new
  end

  # === ログイン処理
  # パラメータで受け渡されたログインID、パスワードに該当するユーザが存在する
  # かどうかチェックし、存在する場合にはメニュー画面にリダイレクトする
  # 存在しない場合には再度ログイン画面を表示する
  def create
    @user_session = UserSession.new(user_session_params)
    if @user_session.save
      redirect_to root_path, notice: "ログインしました"
    else
      render :new
    end
  end

  # === ログアウト処理
  # セッション情報を消去し、ログイン画面にリダイレクトする
  def destroy
    current_user_session.destroy
    redirect_to login_path, notice: "ログアウトしました"
  end

  private

  # === パラメータ項目の許可処理
  def user_session_params
    params.require(:user_session).permit(:login, :password)
  end
end
