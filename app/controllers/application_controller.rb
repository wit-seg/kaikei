# = Applicationコントローラ
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # ログイン中かどうかチェックするメソッドをヘルパーとしても呼び出せるようにする
  helper_method :logged_in?

  # === ログインチェック処理
  # すべてのコントローラ／アクションを呼び出す前にログインチェックし、
  # 未ログインの場合はログイン画面に強制的にリダイレクトする
  # ただし、skip_before_actionでスキップしたアクションは除外する
  before_action :require_login

  private

  # === ログイン中のユーザセッション情報
  # ==== 戻り値
  # ログイン中のユーザセッション情報
  def current_user_session
    return @current_user_session if defined? @current_user_session
    @current_user_session = UserSession.find
  end

  # === ログイン中のユーザ情報
  # ==== 戻り値
  # ログイン中のユーザオブジェクト
  def current_user
    return @current_user if defined? @current_user
    @current_user = current_user_session && current_user_session.user
  end

  # === ログイン状態チェック処理
  # ==== 戻り値
  # * true: ログイン中
  # * false: 未ログイン
  def logged_in?
    !! current_user_session
  end

  # === ログインしていない場合にログイン画面に強制遷移
  def require_login
    redirect_to login_path unless logged_in?
  end

  # === 期間検索条件をセット
  # 年月の検索条件をもとに、開始日／終了日の値をインスタンス変数にセットする
  def set_search_term
    params[:year] ||= Date.today.year
    params[:month] ||= Date.today.month

    @start_date = Date.new(params[:year].to_i, params[:month].to_i, 1)
    @end_date = @start_date.next_month
  end
end
