## step11: 投稿機能の実装

- ブランチ名: feature11/post-create

## ゴール

- ユーザーが新しい投稿を作成できる機能を実装する

## 学習できること

- Railsでのフォームの作成方法
- データの保存方法
- 各種リンクの設定方法

## 実装内容

1. 新しい投稿を作成するコントローラーとアクションを作成する
2. 投稿フォームを作成するビューを作成する
3. バリデーションを設定する
4. ルーティングを設定する
5. ログイン時だけヘッダーに投稿ボタンが表示されるようにする

## チェックリスト

- [ ]  新しい投稿を作成するコントローラーとアクションの作成
    - `app/controllers/posts_controller.rb` を編集し、`new` と `create` アクションを追加すること
    - `new` アクションでは、新しい投稿を作成するためのインスタンス変数を設定すること
    - `create` アクションでは、フォームから送信されたデータを使って新しい投稿を作成し、保存すること
    - 入力値に対してストロングパラメータを設定すること
    - 投稿日時が新しい投稿から降順にすること
    - メッセージの表示
        - 投稿成功時： 投稿が成功しました
        - 投稿失敗時：投稿画面を再度表示
- [ ]  投稿フォームを作成するビューの作成
    - `app/views/posts/new.html.erb` を作成し、下記HTMLを実装すること
        
        ```
        <div class="container mx-auto mt-8" style="width: 80%;">
          <h1 class="text-3xl font-bold mb-6 text-center">New Post</h1>
          <div class="bg-white shadow-md rounded-xl p-6">
            
              <!-- エラーメッセージを表示するためのセクション -->
            <% if @post.errors.any? %>
              <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6">
                <strong class="font-bold"><%= pluralize(@post.errors.count, "error") %> prohibited this post from being saved:</strong>
                <ul>
                  <% @post.errors.full_messages.each do |message| %>
                    <li><%= message %></li>
                  <% end %>
                </ul>
              </div>
            <% end %>
        
            <!-- form_withヘルパーを使用して、POSTリクエストを送信するフォームを作成する -->
            <%= form_with(model: , local: true, class: "space-y-4") do |form| %>
              <!-- タイトルの入力フィールド -->
              <div>
                <%= form.label :title, "Title", class: "block text-gray-700 font-bold mb-2" %>
                <%= form.text_field :title, class: "w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500" %>
              </div>
              <!-- 本文の入力フィールド -->
              <div>
                <%= form.label :body, "Body", class: "block text-gray-700 font-bold mb-2" %>
                <%= form.text_area :body, class: "w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500" %>
              </div>
              <!-- 送信ボタン -->
              <div class="text-center">
                <%= form.submit "Create Post", class: "w-full bg-indigo-600 text-white py-2 px-4 rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2" %>
              </div>
            <% end %>
          </div>
        </div>
        ```
        
    - 投稿のタイトルと本文を入力するフィールド、および送信ボタンを実装すること
- [ ]  バリデーションの設定
    - `Post` モデルにバリデーションを追加
        - `title` ：必須
        - `body` ：必須
- [ ]  ルーティングの設定
    - 新しい投稿を作成するためのパスを設定する
- [ ]  ヘッダーに投稿リンクを追加
    - ログインしている場合のみヘッダーに投稿リンクが表示されるようにすること
    - スタイルは他のリンクと同様にすること
- [ ]  確認
    - ブラウザで `http://localhost:3000/posts/new` にアクセスし、新しい投稿を作成できることを確認する
    - 作成後、投稿一覧ページへ遷移すること
    - 作成した投稿が一番上に表示されること
    - 投稿内に各項目が表示されていること
    - titleもしくはbodyを空で投稿するとエラーとなること
    