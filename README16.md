## step16: ユーザーのプロフィール表示

- ブランチ名: feature16/user-profile

## ゴール

- ユーザーのプロフィールを表示する機能を実装する

## 学習できること

- Railsコントローラーでの詳細表示アクションの作成方法
- ビューでの個々のデータ表示方法
- ルーティングの設定方法

## 実装内容

1. ユーザープロフィールを表示するコントローラーとアクションを作成する
2. ユーザープロフィールを表示するビューを作成する
3. ヘッダーにプロフィールへ遷移するボタンを作成する
4. ルーティングを設定する

## チェックリスト

- [ ]  ユーザープロフィールを表示するコントローラーとアクションの作成
    - `app/controllers/users_controller.rb` に`show` アクションを追加すること
    - `show` アクションでは、特定のユーザーを取得すること
- [ ]  ユーザープロフィールを表示するビューの作成
    - `app/views/users/show.html.erb` を下記のように作成し、ユーザーデータを表示すること
        - 表示項目は以下
            - メールアドレス
            - 登録日時
            - 過去の投稿
                - タイトル（投稿詳細へ遷移するリンクを設定すること）
                - 本文（100文字まで表示すること）
                - 投稿日時
        
        ```
        <div class="container mx-auto mt-8" style="width: 80%;">
          <div class="card bg-white shadow-xl rounded-3xl p-8">
            <h1 class="text-3xl font-bold mb-6 text-center text-blue-600">Profile</h1>
            <div class="prose lg:prose-xl mb-6 text-lg">
              <p>Email: <%= メールアドレスを表示 %></p>
              <p>Registered at: <%= ユーザー登録日時を表示(YYYY-MM-DD hh:mm:ss形式で表示) %></p>
            </div>
            <h2 class="text-2xl font-bold mb-4 text-blue-600">Posts</h2>
            <div class="grid grid-cols-1 gap-6">
              <% @posts.each do |post| %>
                <div class="card bg-white shadow-md rounded-xl p-6">
                  <h3 class="text-xl font-semibold mb-2"><%= link_to タイトルを表示, 投稿詳細へのパス %></h3>
                  <p class="text-gray-700 mb-4"><%= 本文を表示(truncateを使用して100文字まで表示すること) %></p>
                  <div class="text-sm text-gray-500">
                    <%= 投稿日時を表示(YYYY-MM-DD hh:mm:ss形式で表示)  %>
                  </div>
                </div>
              <% end %>
            </div>
          </div>
        </div>
        ```
        
- [ ]  ヘッダーにプロフィールへ遷移するリンクを作成
    - ヘッダーに表示されているメールアドレスを押下後、プロフィールページへ遷移すること
- [ ]  ルーティングの設定
    - 個々のユーザーのプロフィール表示のためのルーティングを設定すること
- [ ]  確認
    - ログイン時のメールアドレスを押下後、プロフィールページへ遷移すること
    - 下記項目が表示されること
        - メールアドレス
        - 登録日時
        - 過去の投稿