## step3: Sorceryの導入

- ブランチ名: feature3/add-sorcery
    
## ゴール
    
- Sorceryを導入し、ユーザー認証の基盤を構築する
    
## 学習できること
    
- 認証ライブラリSorceryの導入方法
- Gemのインストールと設定
    
## 実装内容
    
1. GemfileにSorceryを追加する
2. Sorceryをインストールする
3. Sorceryの設定ファイルを作成する
    
## チェックリスト

- [ ]  GemfileにSorceryを追加
    - `Gemfile` ファイルを開き、`gem 'sorcery'` を追加する
- [ ]  Sorceryをインストール
    - ターミナルで `bundle install` コマンドを実行する(docker-composeのコマンドで)
- [ ]  Sorceryの設定ファイルを作成
    - ターミナルで `rails generate sorcery:install` コマンドを実行する(docker-composeのコマンドで)
    - 生成された `config/initializers/sorcery.rb` ファイルを確認する
