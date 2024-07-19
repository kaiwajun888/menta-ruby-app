## Step19: いいね機能

- ブランチ名: feature19/post-like

## ゴール

- ユーザーが投稿にいいねをつけたり、いいねを解除できる機能を実装する

## 学習できること

- いいね機能の実装方法
- 中間テーブルの使用方法
- Railsコントローラーでのアクションの作成方法
- ビューでのデータ表示方法
- ルーティングの設定方法

## 実装内容

1. いいねを管理するためのモデルと中間テーブルを作成する
2. いいねを管理するコントローラーとアクションを作成する
3. いいね機能を実装するためのビューを作成する
4. ルーティングを設定する

## チェックリスト

- [ ]  いいねを管理するためのモデルと中間テーブルの作成
    - ターミナルでコマンドを実行して、いいねを管理するためのモデルと中間テーブルを作成すること
        - `Like`モデルを作成すること
        - `User`モデル、`Post`モデルとの関連を考慮すること
    - マイグレーションファイルを編集し、適切なインデックスと外部キー制約を追加すること
    - マイグレーションを実行してデータベースを更新すること
        
        ```bash
        docker-compose exec web rails db:migrate
        ```
        
    - UserモデルにLikeモデルとのリレーションを定義すること
        - ユーザーは複数の「いいね」を持つこと
        - ユーザーが削除されたら、関連する「いいね」も削除されること
        - ユーザーは「いいね」を通じて複数の投稿と関連付けられること
        - この関連付けは`liked_posts`と名付けること
        - `liked_posts`は`likes`テーブルを介して取得すること
        - `liked_posts`の対象は Post モデルであること
    - PostモデルにLikeモデルとのリレーションを定義すること
        - 投稿は複数の「いいね」を持つこと
        - 投稿が削除されたら、関連する「いいね」も削除されること
        - 投稿は「いいね」を通じて複数のユーザーと関連付けられること
        - この関連付けは`liking_users`と名付けること
        - `liking_users`は`likes`テーブルを介して取得すること
        - `liking_users`の対象は User モデルであること
- [ ]  いいねを管理するコントローラーとアクションの作成
    - `app/controllers/likes_controller.rb` を作成し、`create` と `destroy` アクションを追加すること
        - ログインユーザーのみが`create` と `destroy` アクションにアクセスできること
        - `create` アクション：いいね状態にする処理
        - `destroy` アクション：いいね解除の処理
        - `respond_to` ブロックを使い、Turbo Stream形式のレスポンスを作成すること
- [ ]  いいね機能を実装するためのビューの作成
    - いいねボタン部分を下記のようにパーシャル化すること
        - いいね解除のパス：現在ログインしているユーザーが特定の投稿に対して行った「いいね」を取得すること
        
        ```
        # app/views/likes/_like.html.erb
        <div id="like_button_<%= post.id %>">
          <% if ログイン時のみ表示する条件 %>
            <% if 現在ログインしているユーザーが特定の投稿に対して行った「いいね」を取得する条件 %>
              <%= button_to 'Unlike', 現在ログインしているユーザーが特定の投稿に対して行った「いいね」を取得するためのパス, method: :delete, remote: true, class: 'bg-red-500 text-white py-2 px-4 rounded-lg' %>
            <% else %>
              <%= button_to 'Like', いいねのパスを設定すること, method: :post, remote: true, class: 'bg-blue-500 text-white py-2 px-4 rounded-lg' %>
            <% end %>
          <% end %>
        </div>
        ```
        
    - `app/views/posts/index.html.erb`にいいねボタンを追加すること
        - パーシャル化したいいねボタンを表示すること
        
        ```html
        <div class="container mx-auto mt-8" style="width: 80%;">
          <h1 class="text-3xl font-bold mb-6 text-center">Post List</h1>
          <div class="grid grid-cols-1 gap-6">
            <% @posts.each do |post| %>
              <div id="post-<%= post.id %>" class="card bg-white shadow-md rounded-xl p-6 hover:bg-gray-100 transition duration-300 ease-in-out relative">
                <%= link_to post_path(post), class: 'no-underline block' do %>
                  <h2 class="text-xl font-semibold mb-2"><%= post.title %></h2>
                  <p class="text-gray-700 mb-4"><%= truncate(post.body, length: 100) %></p>
                  <div class="text-sm text-gray-500">
                    Posted by: <%= link_to post.user.email, user_path(post.user), class: "text-blue-500 underline" %><br>
                    <%= post.created_at.strftime('%Y-%m-%d %H:%M:%S') %>
                  </div>
                <% end %>
                <div class="flex justify-between items-center mt-4">
                  <div class="like-button">
                    <%= パーシャル化したいいねボタンをここに表示 %>
                  </div>
                  <% if logged_in? && post.user == current_user %>
                    <div class="absolute bottom-4 right-4 space-x-2">
                      <%= link_to '編集', edit_post_path(post), class: 'bg-blue-500 text-white py-3.5 px-4 rounded-lg' %>
                      <%= link_to '削除', post_path(post), method: :post, data: { turbo_method: :delete, turbo_confirm: "本当に削除しますか？"}, class: 'bg-red-500 text-white py-3.5 px-4 rounded-lg' %>
                    </div>
                  <% end %>
                </div>
              </div>
            <% end %>
          </div>
        </div>
        ```
        
    - ページをリロードせずにいいねボタンを切り替えるために下記を実装すること
        
        （詳しくは`Turbo Stream`を調べてみてください）
        
        ```
        # app/views/likes/create.turbo_stream.erb
        <%= turbo_stream.replace "like_button_#{@post.id}" do %>
          <%= render 'likes/like', post: @post %>
        <% end %>
        
        # app/views/likes/destroy.turbo_stream.erb
        <%= turbo_stream.replace "like_button_#{@post.id}" do %>
          <%= render 'likes/like', post: @post %>
        <% end %>
        ```
        
- [ ]  ルーティングの設定
    - いいね機能の管理のためのルーティングを設定すること
- [ ]  確認
    - ブラウザで投稿一覧ページにアクセスし、投稿にいいねをつけたり、いいねを解除できることを確認する
    - ログアウト状態ではいいねボタンが表示されないこと