## step13: 投稿の詳細表示

- ブランチ名: feature13/post-show

## ゴール

- 個々の投稿の詳細を表示する機能を実装する

## 学習できること

- Rails コントローラーでの詳細表示アクションの作成方法
- ビューでの個々のデータ表示方法
- ルーティングの設定方法

## 実装内容

1. 投稿の詳細を表示するコントローラーとアクションを作成する
2. 投稿の詳細を表示するビューを作成する
3. ルーティングを設定する

## チェックリスト

- [ ] 投稿の詳細を表示するコントローラーとアクションの作成
  - `app/controllers/posts_controller.rb` を編集し、`show` アクションを追加すること
  - `show` アクションでは、特定の投稿を取得するコードを記述すること
- [ ] 投稿の詳細を表示するビューの作成
  - `app/views/posts/show.html.erb` を作成し、投稿データを表示すること
  - 下記項目を表示すること
    - タイトル
    - 本文
    - メールアドレス
    - 投稿日時
  - 戻るボタンを押下したら、投稿一覧画面に遷移すること
  - 下記 HTML を使用すること
    ```
    <div class="container mx-auto mt-8" style="width: 80%;">
      <div class="card bg-white shadow-xl rounded-3xl p-8">
        <h1 class="text-4xl font-bold mb-6 text-center text-blue-600"><%= ここにタイトルを表示 %></h1>
        <div class="prose lg:prose-xl mb-6 text-lg">
          <p><%= ここに本文を表示 %></p>
        </div>
        <div class="text-sm text-gray-500 mb-4 flex justify-between">
          <div class="text-left">
            <p>Posted by: <span class="font-semibold"><%= ここにメールアドレスを表示 %></span></p>
            <p>Created at: <%= ここに投稿日時を表示（YYYY-MM-DD HH:mm:ss形式で表示） %></p>
          </div>
        </div>
        <div class="flex justify-end">
          <%= link_to '戻る', , class: 'btn btn-primary' %>
        </div>
      </div>
    </div>
    ```
- [ ] 投稿一覧ページの各投稿に詳細ページへのリンクを設定
  - app/views/posts/index.html.erb を下記に修正すること
    ```
    <div class="container mx-auto mt-8" style="width: 80%;">
      <h1 class="text-3xl font-bold mb-6 text-center">Post List</h1>
      <div class="grid grid-cols-1 gap-6">
        <% @posts.each do |post| %>
          <%= link_to post_path(post), class: 'no-underline' do %>
            <div class="card bg-white shadow-md rounded-xl p-6 hover:bg-gray-100 transition duration-300 ease-in-out">
              <h2 class="text-xl font-semibold mb-2"><%= post.title %></h2>
              <p class="text-gray-700 mb-4"><%= truncate(post.body, length: 100) %></p>
              <div class="text-sm text-gray-500">
                Posted by: <%= post.user.email %><br>
                <%= post.created_at.strftime('%Y-%m-%d %H:%M:%S') %>
              </div>
            </div>
          <% end %>
        <% end %>
      </div>
    </div>
    ```
- [ ] ルーティングの設定
  - 投稿詳細を表示するためのパスを設定すること
- [ ] 確認
  - ブラウザで投稿一覧ページにアクセスし、各投稿をクリックして投稿の詳細が表示されること
  - 投稿の詳細が正しく表示されていること
    - タイトル
    - 本文
    - メールアドレス
    - 投稿日時
