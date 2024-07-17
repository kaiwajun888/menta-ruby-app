## step14: 投稿の編集機能

- ブランチ名: feature14/post-edit

## ゴール

- ログインユーザーが自身の投稿を編集できる機能を実装する

## 学習できること

- Railsでの編集フォームの作成方法
- データの更新方法
- ログイン状態の管理方法
- 各種リンクの設定方法

## 実装内容

1. ログインユーザーかつ自身の投稿のみ編集できるようにするためのコントローラーとアクションを作成する
2. 投稿編集フォームを作成するビューを作成する
3. ルーティングを設定する

## チェックリスト

- [ ]  ログインユーザーかつ自身の投稿のみ編集できるようにするコントローラーの作成
    - `app/controllers/posts_controller.rb` を編集し、`edit` と `update` アクションを追加すること
    - `edit` アクションでは、特定の投稿を編集するためのインスタンス変数を設定すること
    - `update` アクションでは、フォームから送信されたデータを使って既存の投稿を更新すること
    - 上記アクションには、ログインユーザーかつそのユーザーが投稿したもののみアクセスできるようにすること
    - 編集成功時：「投稿が更新されました」とメッセージを表示すること
    - 編集失敗時：再度編集画面を表示すること
- [ ]  投稿編集フォームを作成するビューの作成
    - `app/views/posts/edit.html.erb` を作成し、下記のように既存の投稿を編集するためのフォームを追加すること
        - フォームのモデルを設定すること
        - 編集する項目は下記です
            - タイトル
            - 本文
        
        ```
        <h1 class="text-3xl font-bold mb-6 text-center">Edit Post</h1>
        <div class="container mx-auto mt-8" style="width: 80%;">
          <%= form_with(model: , local: true, class: "space-y-4") do |form| %>
            <% if @post.errors.any? %>
              <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6">
                <strong class="font-bold"><%= pluralize(@post.errors.count, "error") %> prohibited this post from being saved:</strong>
                <span class="block sm:inline"><%= @post.errors.full_messages.join(", ") %></span>
              </div>
            <% end %>
            <div>
              <%= form.label , class: "block text-gray-700" %>
              <%= form.text_field , class: "mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" %>
            </div>
            <div>
              <%= form.label , class: "block text-gray-700" %>
              <%= form.text_area , class: "mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" %>
            </div>
            <div class="text-center">
              <%= form.submit '投稿を更新する', class: "w-full bg-indigo-600 text-white py-2 px-4 rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2" %>
            </div>
          <% end %>
        </div>
        ```
        
- [ ]  投稿編集フォームへ遷移するボタンの追加
    - `app/views/posts/index.html.erb`を下記のように修正し、編集ボタンを追加すること
    - 編集フォームへ遷移するようにパスを指定すること
    - ログインユーザーかつログインユーザーが投稿した投稿でのみ編集ボタンを表示すること（`<% if  %>`部分に条件を実装してください）
        
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
                <% if  %>
                  <div class="absolute bottom-4 right-4">
                    <%= link_to '編集', パスを指定する, class: 'btn btn-primary' %>
                  </div>
                <% end %>
              </div>
            <% end %>
          </div>
        </div>
        ```
        
- [ ]  ルーティングの設定
    - 投稿の編集と更新のためのパスを設定すること
- [ ]  確認
    - 投稿一覧ページの各投稿の編集ボタンから編集フォームへ遷移できること
    - タイトル、本文が編集できること
    - ログインユーザーかつ自身の投稿のみ編集できること