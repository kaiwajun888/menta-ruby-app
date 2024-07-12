## step6: サインイン機能の実装

- ブランチ名: feature6/user-signup

## ゴール

- 新しいユーザーがサインインできる機能を実装する

## 学習できること

- ユーザーモデルの作成
- ユーザー登録フォームの作成
- Sorceryを用いたユーザー認証の設定

## 実装内容

1. ユーザーモデルを作成する
2. ユーザー登録フォームを作成する
3. サインイン処理を実装する

## チェックリスト

- [ ]  ユーザーモデルの作成
    - `User` テーブルを作成するために必要なカラムは `email`, `crypted_password`, `salt` です
    - テーブル作成のためのマイグレーションファイルを作成し、適用する
- [ ]  ユーザーモデルでバリデーションを設定する
    - メールアドレス
        - 存在は必須であること
        - 一意であること
    - パスワード
        - 新規作成時やパスワードが変更されたときに、6文字以上であること
        - パスワードの確認を行い、一致することをチェックできること
    - パスワード確認
        - 新規作成時やパスワードが変更されたときに、必須とすること
- [ ]  ユーザー登録フォームの作成
    - `app/views/users/new.html.erb` を作成し、以下のHTMLとCSSを使用して、フォームの設定を行う
        
        ```html
        <div class="min-h-screen flex flex-col items-center justify-center bg-gray-100">
          <div class="bg-white p-8 rounded shadow-md w-full max-w-md">
            <h1 class="text-2xl font-bold mb-6 text-center">Sign Up</h1>
            <!-- users_controller.rb を確認して、フォームのモデルに適用してください -->
            <%= form_with(model: @user, local: true, class: "space-y-4") do |form| %>
              <% if @user.errors.any? %>
                <div id="error_explanation" class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6">
                  <strong class="font-bold"><%= pluralize(@user.errors.count, "error") %> prohibited this user from being saved:</strong>
                  <span class="block sm:inline"><%= @user.errors.full_messages.join(", ") %></span>
                </div>
              <% end %>
              <div class="mb-4">
              <!-- フィールドのラベルに適切なシンボルを指定してください -->
                <%= form.label , class: "block text-gray-700" %>
                <%= form.email_field :email, class: "mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" %>
              </div>
              <div class="mb-4">
              <!-- フィールドのラベルに適切なシンボルを指定してください -->
                <%= form.label , class: "block text-gray-700" %>
                <%= form.password_field :password, class: "mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" %>
              </div>
              <div class="mb-4">
              <!-- フィールドのラベルに適切なシンボルを指定してください -->
                <%= form.label , class: "block text-gray-700" %>
                <%= form.password_field :password_confirmation, class: "mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" %>
              </div>
              <div class="text-center">
                <%= form.submit 'Sign Up', class: "w-full bg-indigo-600 text-white py-2 px-4 rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2" %>
              </div>
            <% end %>
          </div>
        </div>
        ```
        
- [ ]  サインイン処理の実装
    - `User` モデルに `authenticates_with_sorcery!` を追加する
    - `app/controllers/users_controller.rb` を作成し、`new` と `create` アクションを追加する
    - `create` アクションにユーザー登録のロジックを追加する
    - ストロングパラメータ `user_params` を使用すること
- [ ]  ルーティングの設定
    - 今回の実装内容に沿うように`config/routes.rb` を修正する
- [ ]  動作確認をすること
    - メールアドレス、パスワードを入力し、サインインできること
    - データベースにユーザー情報が保存されていることを確認すること
    ```
    # docker-compose exec web rails console
    > User.all

    # 下記のように登録したユーザー情報が表示されればOK
    irb(main):001> User.all
      User Load (0.5ms)  SELECT "users".* FROM "users"
    => 
    [#<User:0x00007f49367147e8
      id: 1,
      email: "test1@email.com",
      crypted_password: "$2a$10$kjkNXIrly7Ku4XAtqMK0gOu6WMQDYGobpkfFJNQa9dOdlH7NDNqXu",
      salt: "rtHvzQZn-X9hvzDu7tDW",
      created_at: Fri, 12 Jul 2024 07:43:43.679483000 UTC +00:00,
      updated_at: Fri, 12 Jul 2024 07:43:43.679483000 UTC +00:00>]
    ```
