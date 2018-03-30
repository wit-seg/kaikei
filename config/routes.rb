Rails.application.routes.draw do
  # === メニュー画面の設定
  get 'menu/index'

  # === パスワード変更
  resource :password, only: [:edit, :update]

  # === 仕訳入力
  resources :entries

  # === 帳票出力
  namespace :reports do
    get :output_journal
    get :journal
    get :output_general_ledger
    get :general_ledger
  end
  
  # === 勘定科目マスタメンテナンス
  resources :items

  # === 取引先マスタメンテナンス
  resources :suppliers

  # === ログイン認証関連の設定
  # 「/login」でログイン画面表示を、「/logout」でログアウト処理を呼び出せるよう設定
  resource :user_session, only: [:new, :create, :destroy]
  get "/login", to: "user_sessions#new"
  delete "/logout", to: "user_sessions#destroy"

  # === ルートパスでアクセスするコントローラ／アクションの設定
  root "menu#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
