## step15: 投稿の削除機能

- ブランチ名: feature15/post-delete

## ゴール

- ユーザーが自身の投稿を削除できる機能を実装する

## 学習できること

- Railsでの削除アクションの作成方法
- データの削除方法
- ログイン状態の管理方法
- 各種リンクの設定方法

## 実装内容

1. ログインユーザーかつ自身の投稿のみ削除できるようにするためのコントローラーとアクションを作成する
2. 投稿削除リンクを追加するビューを作成する
3. ルーティングを設定する

※Rails7系から削除機能の書き方がこれまのバージョンと変わっています

下記の記事を参考に実装してみてください

[Rails7でdestroyが効かない - Qiita](https://qiita.com/yyzzyykk/items/2ce6444fef7028bd9490)

## チェックリスト

- [ ]  ログインユーザーかつ自身の投稿のみ削除できるようにするコントローラーの作成
    - `app/controllers/posts_controller.rb` を編集し、`destroy` アクションを追加すること
    - `destroy` アクションでは、特定の投稿を削除するためのコードを記述すること
    - 上記アクションには、ログインしているユーザーかつそのユーザーが投稿したもののみアクセスできるようにすること
- [ ]  投稿削除リンクを追加するビューの作成
    - `app/views/posts/index.html.erb`を下記のように修正し、削除ボタンを追加すること
    - 削除ボタンを押下後、確認メッセージ「本当に削除しますか？」を表示すること
        
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
                    Posted by: <%= post.user.email %><br>
                    <%= post.created_at.strftime('%Y-%m-%d %H:%M:%S') %>
                  </div>
                <% end %>
                <% if logged_in? && post.user == current_user %>
                  <div class="absolute bottom-4 right-4 space-x-2">
                    <%= link_to '編集', edit_post_path(post), class: 'bg-blue-500 text-white py-3.5 px-4 rounded-lg' %>
                    <%= link_to '削除', パスを設定, メソッドを設定, data: { dataを設定 }, class: 'bg-red-500 text-white py-3.5 px-4 rounded-lg' %>
                  </div>
                <% end %>
              </div>
            <% end %>
          </div>
        </div>
        ```
        
- [ ]  ルーティングの設定
    - 投稿の削除のためのパスを設定すること
- [ ]  確認
    - 投稿一覧ページの各投稿の削除ボタンから、投稿の削除ができること