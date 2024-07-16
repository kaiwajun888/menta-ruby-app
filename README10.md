## step10: 投稿一覧の表示

- ブランチ名: feature10/post-index

## ゴール

- 作成した投稿データを一覧表示する機能を実装する

## 学習できること

- Railsコントローラーの作成方法
- ビューでのデータ表示方法
- 各種リンクの設定方法

## 実装内容

1. 投稿一覧を表示するコントローラーとアクションを作成
2. 投稿一覧を表示するビューを作成
3. ルーティングを設定

## チェックリスト

- [ ]  投稿一覧を表示するコントローラーとアクションの作成
    - `app/controllers/posts_controller.rb` を作成し、`index` アクションを追加すること
    - `index` アクションでは、すべての投稿を取得するコードを記述すること
- [ ]  投稿一覧を表示するビューの作成
    - `app/views/posts/index.html.erb` を作成し、下記HTMLを実装すること
        
        ```
        <div class="container mx-auto mt-8" style="width: 80%;">
          <h1 class="text-3xl font-bold mb-6 text-center">Post List</h1>
          <div class="grid grid-cols-1 gap-6">
            <% ここに全ての投稿を表示するロジックを書くこと %>
              <div class="card bg-white shadow-md rounded-xl p-6">
                <!-- 投稿のタイトルを表示する -->
                <h2 class="text-xl font-semibold mb-2"><%= タイトルをここに表示 %></h2>
                <!-- 投稿の本文を表示する -->
                <p class="text-gray-700 mb-4"><%= 投稿の本文をここに表示 %></p>
                <div class="text-sm text-gray-500">
                  <!-- 投稿者のメールアドレスと作成日時を表示する -->
                  Posted by: <%= 投稿者のメールアドレスをここに表示 %><br>
                  <%= 投稿日時をここに表示（YYYY-MM-DD HH:mm:ss形式で表示） %>
                </div>
              </div>
            <% end %>
          </div>
        </div>
        ```
        
    - 各投稿のタイトル、本文、作成日時、投稿者を表示すること
    - コントローラーの`index` アクションで取得した投稿全てを表示すること
- [ ]  ルーティングの設定
    - ルートパス（`/`）を投稿一覧ページに設定すること
    - 投稿の一覧表示のためのルーティングを設定すること
- [ ]  確認
    - ブラウザで `http://localhost:3000` にアクセスし、投稿一覧が表示されること