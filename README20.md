## Step20: コメント機能

- ブランチ名: feature20/post-comment

## ゴール

- ユーザーが投稿にコメントを追加できる機能を実装する

## 学習できること

- コメント機能の実装方法
- 中間テーブルの使用方法
- Railsコントローラーでのアクションの作成方法
- ビューでのデータ表示方法
- ルーティングの設定方法

## 実装内容

1. コメントを管理するためのモデルとテーブルを作成する
2. コメントを管理するコントローラーとアクションを作成する
3. コメント機能を実装するためのビューを作成する
4. ルーティングを設定する

## チェックリスト

- [ ]  コメントを管理するためのモデルとテーブルの作成
    - ターミナルで以下のコマンドを実行して、コメントを管理するためのモデルとテーブルを作成する
        - モデル名は `Comment` とすること
        - `Comment` モデルは `user` と `post` に関連付けること
        - `Comment` モデルは `content` というテキスト属性を持つこと
        - `user` と `post` の関連は `references` 型で定義すること
        - `user` と `post` には外部キー制約を設けること
        - コメントは空で保存できないようにすること
        - 最低文字数を1とすること
    - マイグレーションファイルを編集し、適切なインデックスと外部キー制約を追加する
        - `content`は空欄を許可しないこと
    - マイグレーションを実行してデータベースを更新する
        
        ```bash
        docker-compose exec web rails db:migrate
        ```
        
    - UserモデルにCommentモデルとのリレーションを定義すること
        - 複数の `Comment` を持つこと
        - `Comment` の削除は、関連する `Comment` も削除すること
    - PostモデルにCommentモデルとのリレーションを定義すること
        - 複数の `Comment` を持つこと
        - `Comment` の削除は、関連する `Comment` も削除すること
        
        ```ruby
        # app/models/user.rb
        class User < ApplicationRecord
          has_many :comments, dependent: :destroy
        end
        
        # app/models/post.rb
        class Post < ApplicationRecord
          has_many :comments, dependent: :destroy
        end
        
        # app/models/comment.rb
        class Comment < ApplicationRecord
          belongs_to :user
          belongs_to :post
        end
        ```
        
- [ ]  コメントを管理するコントローラーとアクションの作成
    - `app/controllers/comments_controller.rb` を作成し、`create` アクションを追加する
        - ログインユーザーのみが`create` アクションにアクセスできること
        - ストロングパラメータ`comment_params`を設けること
        - メッセージの表示
            - コメント成功時：`コメントが作成されました`と表示し、ページ遷移しないこと
            - コメント失敗時：`コメント作成に失敗しました`と表示し、ページ遷移しないこと
- [ ]  コメント機能を実装するためのビューの作成
    - 投稿一覧の各投稿にコメントアイコンを実装すること
        
        ```
        # app/views/posts/index.html.erb
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
                  <div class="flex space-x-2">
                    <div class="like-button">
                      <%= render 'likes/like', post: post %>
                    </div>
                    <div class="comment-button">
                      <%= render パーシャル化されたコメントアイコンをここに表示, post: post %>
                    </div>
                  </div>
                  <% if logged_in? && post.user == current_user %>
                    <div class="flex space-x-2 absolute bottom-4 right-4">
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
        
    - コメントアイコン部分はパーシャル化すること
        - 投稿詳細ページへ遷移すること
        
        ```
        # app/views/comments/_comment_button.html.erb
        <div class="comment-button">
          <%= link_to パスを設定すること do %>
            <%= image_tag 'comment.svg', class: 'h-6 w-6 text-gray-500' %>
          <% end %>
        </div>
        ```
        
    - 投稿詳細ページにコメント表示部分とコメントフォームを追加すること
        - コメント表示項目
            - コメント内容
            - コメントしたユーザー名（メールアドレス）
            - コメントした日時
        - コメントフォーム
            - ログイン時のみ表示されること
        
        ```html
        # app/views/posts/show.html.erb
        <div class="container mx-auto mt-8" style="width: 80%;">
          <div class="card bg-white shadow-xl rounded-3xl p-8">
            <h1 class="text-4xl font-bold mb-6 text-center text-blue-600"><%= @post.title %></h1>
            <div class="prose lg:prose-xl mb-6 text-lg">
              <p><%= @post.body %></p>
            </div>
            <div class="text-sm text-gray-500 mb-4 flex justify-between">
              <div class="text-left">
                <p>Posted by: <span class="font-semibold"><%= @post.user.email %></span></p>
                <p>Created at: <%= @post.created_at.strftime("%Y-%m-%d %H:%M:%S") %></p>
              </div>
            </div>
            
            <!-- コメント表示部分 -->
            <div class="mt-8">
              <h2 class="text-2xl font-semibold mb-4">コメント</h2>
              <% @post.comments.each do |comment| %>
                <div class="p-4 bg-gray-100 rounded-md shadow mb-4">
                  <p class="text-gray-700"><%= コメント内容を表示すること %></p>
                  <p class="text-sm text-gray-500">Commented by: <%= link_to コメントしたユーザー名を表示すること, パスを設定すること, class: "text-blue-500 underline" %></p>
                  <p class="text-sm text-gray-500"><%= コメント日時を表示すること(YYYY-MM-DD hh:mm:ss形式) %></p>
                </div>
              <% end %>
            </div>
        
            <!-- コメントフォーム -->
            <% if ログイン時のみ表示すること %>
              <div class="mt-8">
                <%= form_with(model: モデルを設定すること, local: true) do |form| %>
                  <div class="mb-4">
                    <%= form.label ラベルを設定すること, class: "block text-gray-700" %>
                    <%= form.text_area ラベルを設定すること, class: "mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" %>
                  </div>
                  <div class="text-center">
                    <%= form.submit 'コメントをする', class: "w-full bg-indigo-600 text-white py-2 px-4 rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2" %>
                  </div>
                <% end %>
              </div>
            <% end %>
        
            <div class="flex justify-end mt-4">
              <%= link_to '戻る', posts_path, class: 'btn btn-primary' %>
            </div>
          </div>
        </div>
        
        ```
        
- [ ]  ルーティングの設定
    - コメント機能の管理のためのルーティングを設定すること
- [ ]  確認
    - ブラウザで投稿一覧アクセスし、各投稿のアイコンから投稿詳細ページへ遷移できること
    - 投稿詳細ページでコメントができること
    - 入力欄を空にしてコメントしようとすると「コメントに失敗しました」と表示されること