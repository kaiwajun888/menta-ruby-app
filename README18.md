## Step18: フォロー・フォロワー機能

- ブランチ名: feature18/user-follow

## ゴール

- ユーザーが他のユーザーをフォローおよびフォロー解除できる機能を実装する

## 学習できること

- フォロー・フォロワー関係を実装する方法
- 中間テーブルの使用方法
- Railsコントローラーでのアクションの作成方法
- ビューでのデータ表示方法
- ルーティングの設定方法

## 実装内容

1. フォロー・フォロワー関係を管理するためのモデルと中間テーブルを作成する
2. フォロー・フォロワー関係を管理するコントローラーとアクションを作成する
3. フォロー・フォロワー関係を管理するモデルを設定する
4. フォロー・フォロワー機能を実装するためのビューを作成する
5. ルーティングを設定する

## チェックリスト

- [ ]  フォロー・フォロワー関係を管理するためのモデルと中間テーブルの作成
    - 下記コマンドを実行し、フォロー・フォロワー関係を管理するためのモデルと中間テーブルを作成すること
    
    ```bash
    docker-compose exec web rails generate model Relationship follower_id:integer followed_id:integer
    ```
    
    - マイグレーションファイルを下記のように編集し、適切なインデックスと外部キー制約を追加する
    
    ```ruby
    # db/migrate/XXXXXX_create_relationships.rb
    class CreateRelationships < ActiveRecord::Migration[7.0]
      def change
        create_table :relationships do |t|
          t.integer :follower_id, null: false
          t.integer :followed_id, null: false
    
          t.timestamps
        end
        add_index :relationships, :follower_id
        add_index :relationships, :followed_id
        add_index :relationships, [:follower_id, :followed_id], unique: true
        add_foreign_key :relationships, :users, column: :follower_id
        add_foreign_key :relationships, :users, column: :followed_id
      end
    end
    ```
    
    - マイグレーションを実行してデータベースを更新すること
    - `app/models/user.rb`にフォロー・フォロワー関係を定義すること
        - `active_relationships`の設定
            
            クラス名：`"Relationship"`
            外部キー：`"follower_id"`
            関連するレコードが削除された場合、これを自動的に削除する設定を追加
            
        - `following`の設定
            
            中間テーブルとして`active_relationships`を使用
            関連先：`"followed"`
            
        - `passive_relationships`の設定
            
            クラス名：`"Relationship"`
            外部キー：`"followed_id"`
            関連するレコードが削除された場合、これを自動的に削除する設定を追加
            
        - `followers`の設定
            
            中間テーブルとして`passive_relationships`を使用
            関連先：`"follower"`
            
        - `follow`メソッドの追加
            
            他のユーザーをフォローするためのメソッドを定義
            
        - `unfollow`メソッドの追加
            
            他のユーザーのフォローを解除するためのメソッドを定義
            
        - `following?`メソッドの追加
            
            特定のユーザーをフォローしているか確認するためのメソッドを定義
            
        - `followers_count`メソッドの追加
            
            フォロワー数をカウントするためのメソッドを定義
            
        - `following_count`メソッドの追加
            
            フォロー中のユーザー数をカウントするためのメソッドを定義
            
- [ ]  フォロー・フォロワー関係を管理するコントローラーとアクションの作成
    - `app/controllers/relationships_controller.rb` を作成し、`create` と `destroy` アクションを追加すること
        - ログインユーザーのみ`create` と `destroy` アクションにアクセスできるようにすること
        - `create` ：未フォロー→フォロー の処理
        - `destroy` ：フォロー→未フォロー の処理
- [ ]  フォロー・フォロワー関係を管理するモデルの設定
    - `app/models/relationship.rb`を作成すること
        - `follower` と `followed` は `User` モデルとの関連を定義すること
- [ ]  フォロー・フォロワー機能を実装するためのビューの作成
    - `app/views/users/show.html.erb`を下記のように修正すること
        - フォローする・フォロー中のボタンを追加すること
        - フォローする・フォロー中のボタンはログインユーザー自身のプロフィールでは表示しないこと
        - フォロー数、フォロワー数を表示すること
            
            ```html
            <div class="container mx-auto mt-8" style="width: 80%;">
              <div class="bg-white shadow-xl rounded-3xl p-8 relative">
                <div class="absolute top-4 right-4 flex space-x-4">
                  <div class="text-center">
                    <p class="text-xl font-bold"><%= フォロー数を表示すること %></p>
                    <p class="text-gray-600">フォロー中</p>
                  </div>
                  <div class="text-center">
                    <p class="text-xl font-bold"><%= フォロワー数を表示すること %></p>
                    <p class="text-gray-600">フォロワー</p>
                  </div>
                </div>
                <div class="flex items-center mb-6">
                  <%= image_tag @user.avatar.url, alt: "Avatar", class: "w-24 h-24 rounded-full bg-gray-200 mr-4" %>
                  <div>
                    <h1 class="text-3xl font-bold"><%= @user.email %></h1>
                    <p>登録日: <%= @user.created_at.strftime("%Y-%m-%d") %></p>
                  </div>
                </div>
                <% if @user != current_user %>
                  <% if フォロー中を表示する条件を実装すること %>
                    <%= button_to 'フォロー中', パスを実装すること, メソッドを実装すること, class: 'btn btn-danger' %>
                  <% else %>
                    <%= button_to 'フォローする', パスを実装すること, メソッドを実装すること, class: 'btn btn-primary' %>
                  <% end %>
                <% end %>
                <h2 class="text-2xl font-semibold mb-4">過去の投稿</h2>
                <div class="space-y-4">
                  <% @posts.each do |post| %>
                    <div class="p-4 bg-gray-100 rounded-md shadow">
                      <h3 class="text-xl font-bold"><%= post.title %></h3>
                      <p class="text-gray-700"><%= truncate(post.body, length: 100) %></p>
                      <p class="text-sm text-gray-500">投稿日時: <%= post.created_at.strftime("%Y-%m-%d %H:%M:%S") %></p>
                    </div>
                  <% end %>
                </div>
                <div class="text-center mt-4">
                  <%= link_to '編集', edit_user_path(@user), class: 'btn btn-primary' %>
                </div>
              </div>
            </div>
            ```
            
    - `app/views/posts/index.html.erb`を下記のように修正すること
        - 各投稿のメールアドレスを押下して、プロフィールページへ遷移させること
        
        ```
        <div class="container mx-auto mt-8" style="width: 80%;">
          <h1 class="text-3xl font-bold mb-6 text-center">Post List</h1>
          <div class="grid grid-cols-1 gap-6">
            <% @posts.each do |post| %>
              <div class="card bg-white shadow-md rounded-xl p-6 hover:bg-gray-100 transition duration-300 ease-in-out relative">
                <%= link_to post_path(post), class: 'no-underline block' do %>
                  <h2 class="text-xl font-semibold mb-2"><%= post.title %></h2>
                  <p class="text-gray-700 mb-4"><%= truncate(post.body, length: 100) %></p>
                  <div class="text-sm text-gray-500">
                    Posted by: <%= link_to post.user.email, パスを設定すること, class: "text-blue-500 underline" %><br>
                    <%= post.created_at.strftime('%Y-%m-%d %H:%M:%S') %>
                  </div>
                <% end %>
                <% if logged_in? && post.user == current_user %>
                  <div class="absolute bottom-4 right-4 space-x-2">
                    <%= link_to '編集', edit_post_path(post), class: 'bg-blue-500 text-white py-3.5 px-4 rounded-lg' %>
                    <%= link_to '削除', post_path(post), method: :post, data: { turbo_method: :delete, turbo_confirm: "本当に削除しますか？"}, class: 'bg-red-500 text-white py-3.5 px-4 rounded-lg' %>
                  </div>
                <% end %>
              </div>
            <% end %>
          </div>
        </div>
        ```
        
- [ ]  ルーティングの設定
    - フォロー・フォロワー関係の管理のためのルーティングを設定すること
- [ ]  確認
    - ログインユーザーではないユーザーのプロフィールページにアクセスし、フォローおよびフォロー解除できること
    - ログインユーザー自身のプロフィールページでは、フォローボタンは非表示であること
    - プロフィールページにフォロー数、フォロワー数が表示されること