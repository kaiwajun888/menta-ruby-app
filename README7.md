## step7: ログイン機能の実装

- ブランチ名: feature7/user-login

## ゴール

- 登録済みのユーザーがログインできる機能を実装する

## 学習できること

- ログインフォームの作成
- ログイン処理の実装

## 実装内容

1. ログインフォームを作成する
2. ログイン処理を実装する

## チェックリスト

- [ ]  ログインフォームの作成
    - `app/views/sessions/new.html.erb` に以下のHTMLとCSSを使用して、フォームの設定を行う
        
        ```html
        <div class="min-h-screen flex flex-col items-center justify-center bg-gray-100">
          <div class="bg-white p-8 rounded shadow-md w-full max-w-md">
            <h1 class="text-2xl font-bold mb-6 text-center">Login</h1>
            <!-- sessions_controller.rb での実装に合わせて、フォームのURLに適用してください -->
            <%= form_with(url: , local: true, class: "space-y-4") do |form| %>
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
              <div class="text-center">
                <%= form.submit 'Login', class: "w-full bg-indigo-600 text-white py-2 px-4 rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2" %>
              </div>
            <% end %>
          </div>
        </div>
        ```
        
- [ ]  ログイン処理の実装
    - `sessions_controller.rb` の `create` アクションを追加し、ログインのロジックを実装する
    - ログイン成功時：ルート画面に遷移すること
    - ログイン失敗時：ログインの入力画面を再度表示すること
- [ ]  動作確認
    - ログイン成功時にルート画面に遷移すること
    - ヘッダーにログイン時のメールアドレスが表示されること
