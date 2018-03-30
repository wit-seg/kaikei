会計システム
====
商業高校の授業の一環で作成したシステムを元に作成した会計システムです。  
基本的な仕訳入力といくつかの帳票出力を実施することができます。  
各マスタの内容等、適宜書き換えてご使用ください。


## 機能
* 仕訳入力機能  
* 仕訳一覧表示機能
* 各種帳票PDF出力機能
  * 仕訳帳
  * 総勘定元帳


## バージョン情報
* Ruby 2.3.3
* Rails 5.1.4
* MySQL 5.x

## 導入手順
1. bundle install
2. config/database.yml のデータベース接続情報を変更
3. rake db:create
4. rake db:migrate
5. rake db:seed
6. rails s
7. http://localhost:3000/

  ※ログイン情報は、db/seeds.rb を参照してください

## LICENSE

This software is released under the MIT License, see [LICENSE](https://github.com/wit-seg/kaikei/blob/master/LICENSE).
