# Nagano-Cake

<ながのCAKE>の商品を通販するECサイト

![ダウンロード](https://user-images.githubusercontent.com/103346206/186650208-81d25496-c34e-4e62-84b5-8aca888e250e.png)

# 概要

## 顧客側の機能
 - アカウント作成なし、もしくは、ログインなしで商品の閲覧が可能。
 - 通販の利用にはアカウント作成し、ログインする必要がある。その後、商品をカートに入れ、注文が可能になる。
 - 商品の配送先は自身の住所以外にも登録でき、その登録先に配送が可能。
 - カート内で購入予定の個数変更や商品の追加も可能。
 - 注文情報入力では支払方法をクレジットカードと銀行振込から選択可能。
 - 注文履歴一覧で注文状況を確認することが可能。
 - 注文履歴の詳細も確認可能。
 
## 管理者側の機能
 - 管理者側専用の新規登録ページで登録しログイン状態で、商品の新規登録と閲覧が可能。
 - 商品一覧で商品のステータスを確認可能。
 - 会員（顧客）一覧で当サイトで登録している会員を閲覧でき、それらの会員が有効か退会かを確認可能。
 - ジャンルの追加ができ、閲覧も可能。
 - 注文履歴一覧で各注文詳細を閲覧可能。
 
 ## 使用方法
 
 ### インストール
 1. $ git clone git@github.com:Travellers2022/nagano-cake.git(SSH)
 or
 $ git clone https://github.com/Travellers2022/nagano-cake.git(HTTPS)
 2. $ cd nagano-cake
 3. $ bundle install
 4. $ rails db:migrate
 5. $ rails db:see
 6. $ rails s -b 0.0.0.0
 
 ###　テスト
 ターミナル、もしくはコマンドプロンプトで上記の作業後、ローカルサーバーにアクセスしてご覧ください。
 
 [管理者テスト用アカウント]
 
 ID:admin@admin.com
 
 PW:adminadmin  
 
 [顧客テスト用アカウント]
 
ID:customer@customer.com

PW:customercustomer

（登録画面で新規登録も可能）

## 使用言語
- HTML&CSS
- Ruby
- JavaScript
- フレームワーク
  - Ruby on Rails (6.1.6.1)
  
## Gem
- bootstrap
- devise
- kaminari
- pry-byebug

## 作成者
チーム名：トラベラーズ  

メンバー：
- 岡野てぃー 
- こと
- たっくん

