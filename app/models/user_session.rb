# = UserSessionモデル
# Authlogicの認証セッションで使用するためのモデル
class UserSession < Authlogic::Session::Base
  secure Rails.env.production?
  httponly true
end
