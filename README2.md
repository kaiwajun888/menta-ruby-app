## step2: 画面遷移の設定

- ブランチ名: feature2/setup-routes
    
## ゴール
    
- アプリケーションの基本的な画面遷移を設定し、各ページへのルーティングを実装する
    
## 学習できること
    
- Railsでのルーティングの設定方法
- 各コントローラーとビューの作成方法
- ルートとビューの関連付け
    
## 実装内容
    
1. topコントローラーの作成
2. Usersコントローラーの作成
3. Sessionsコントローラーの作成
4. 各コントローラーに対応するビューの作成
5. routes.rbに基本的なルーティングを設定
6. 各ビューに簡易なリンクを作成し、画面遷移を確認する
    
## チェックリスト

- [x]  Topコントローラーの作成
    - `app/controllers/tops_controller.rb` ファイルを作成し、`index`アクションを追加する。
- [ ]  Usersコントローラーの作成
    - `app/controllers/users_controller.rb` ファイルを作成し、`new`アクションを追加する。
- [ ]  Sessionsコントローラーの作成
    - `app/controllers/sessions_controller.rb` ファイルを作成し、`new`アクションを追加する。
- [ ]  各コントローラーに対応するビューの作成
    - `app/views/tops/index.html.erb` ファイルを作成し、以下を実行する:
        - [ ]  「Sign Up | Login」リンクを作成すること
        - [ ]  `Sign Up` リンクが `app/views/users/new.html.erb` に遷移すること
        - [ ]  `Login` リンクが `app/views/sessions/new.html.erb` に遷移すること
        - [ ]  下記テンプレートを使用してください
            
            ```
            <h1>Welcome to the Top Page</h1>
            <a href="<%=  %>">Sign Up</a>
            <a href="<%=  %>">Login</a>
            ```
            
    - `app/views/users/new.html.erb` ファイルを作成し、以下を実行する:
        - [ ]  「Back to Top」リンクを作成すること
        - [ ]  `Back to Top` リンクが `app/views/tops/index.html.erb` に遷移すること
        - [ ]  下記テンプレートを使用してください
            
            ```
            <h1>Login</h1>
            <%= link_to 'Back to Top',  %>
            ```
            
    - `app/views/sessions/new.html.erb` ファイルを作成し、以下を実行する:
        - [ ]  「Back to Top」リンクを作成すること
        - [ ]  `Back to Top` リンクが `app/views/tops/index.html.erb` に遷移すること
        - [ ]  下記テンプレートを使用してください

            ```
            <h1>Login</h1>
            <%= link_to 'Back to Top',  %>
            ```