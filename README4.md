## step4: 共通レイアウトの実装

- ブランチ名: feature4/setup-layout

## ゴール

- ヘッダーやフッターを共通レイアウトとして実装する。

## 学習できること

- Railsのレイアウト機能を使って、共通のヘッダーとフッターを設定する方法
- ヘッダーとフッターのパーシャル化

## 実装内容

1. 共通レイアウトファイルを作成する
2. ヘッダーとフッターを追加する
3. 各ページで共通レイアウトを使用する

## チェックリスト

- [ ]  共通レイアウトファイルを作成
    - 以下の3つのHTMLを使用して、共通のヘッダーとフッターを追加する。
    - どのファイルに追記すべきかを考えてみてください（パーシャル化）
        
        ```html
        <!DOCTYPE html>
        <html>
          <head>
            <title>SampleApp</title>
            <meta name="viewport" content="width=device-width,initial-scale=1">
            <%= csrf_meta_tags %>
            <%= csp_meta_tag %>
        
            <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
            <%= javascript_importmap_tags %>
          </head>
        
          <body class="bg-gray-100 flex flex-col min-h-screen">
            <%= render 'layouts/header' %>
        
            <div class="flex-grow container mx-auto mt-8 min-h-[500px]">
              <%= yield %>
            </div>
        
            <%= render 'layouts/footer' %>
          </body>
        </html>
        ```
        
        ```
        <header class="bg-blue-500 p-4">
          <nav class="container mx-auto flex justify-between items-center">
            <%= link_to 'Top', root_path, class: "text-white font-semibold" %>
            <div>
              <%= link_to 'Sign Up', new_session_path, class: "text-white mx-2" %>
              <%= link_to 'Login', new_user_path, class: "text-white mx-2" %>
            </div>
          </nav>
        </header>
        ```
        
        ```
        <footer class="bg-gray-200 p-4 mt-8">
          <div class="container mx-auto text-center text-gray-700">
            <p>MyApp ©2024</p>
          </div>
        </footer>
        ```
        
- [ ]  `app/views/sessions/new.html.erb`の`Back to Top`を削除する
- [ ]  `app/views/users/new.html.erb`の`Back to Top`を削除する
- [ ]  `app/views/tops/index.html.erb`の`Sign Up`、`Login`を削除
