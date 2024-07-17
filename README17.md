## step17: プロフィール画像の設定

- ブランチ名: feature17/user-avatar

## ゴール

- ユーザーがプロフィール画像をアップロードおよび表示できる機能を実装する

## 学習できること

- CarrierWaveを使用した画像のアップロード機能の実装方法
- 画像の表示方法
- フォームでのファイル入力フィールドの使用方法
- 各種リンクの設定方法

## 実装内容

1. 画像アップロード用のGemを追加する
2. プロフィール画像を保存するためのマイグレーションを作成する
3. プロフィール画像をアップロードするためのフォームを作成する
4. プロフィール画像を表示するビューを作成する

## チェックリスト

- [ ]  画像アップロード用のGemを追加すること
    - `Gemfile` に `carrierwave` や `mini_magick` などの画像アップロード用Gemを追加し、バンドルインストールする
        
        ```ruby
        gem 'carrierwave'
        gem 'mini_magick'
        ```
        
    - ターミナルで `bundle install` を実行する
        
        ```
        docker-compose exec web bundle install
        ```
        
- [ ]  プロフィール画像を保存するためのマイグレーションを作成
    - ターミナルで以下のコマンドを実行して、プロフィール画像用のカラムをユーザーモデルに追加するマイグレーションファイルを作成すること
        
        ```bash
        docker-compose exec web rails generate migration AddAvatarToUsers avatar:string
        ```
        
    - マイグレーションを実行してデータベースを更新すること
        
        ```bash
        docker-compose exec web rails db:migrate
        ```
        
- [ ]  プロフィール画像をアップロードするためのフォームを作成
    - `app/uploaders/avatar_uploader.rb` を作成し、CarrierWaveの設定を行うこと
        
        ```ruby
        # app/uploaders/avatar_uploader.rb
        class AvatarUploader < CarrierWave::Uploader::Base
          include CarrierWave::MiniMagick
        
          storage :file
        
          def store_dir
            "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
          end
        
          def extension_allowlist
            %w(jpg jpeg gif png webp)
          end
        
          def default_url(*args)
            ActionController::Base.helpers.asset_path("user_hoso.png")
          end
        
          process resize_to_fill: [200, 200]
        
          version :thumb do
            process resize_to_fill: [50, 50]
          end
        end
        ```
        
    - `app/models/user.rb` にアップローダーをマウントする設定を追加すること
        
        ```ruby
        # app/models/user.rb
        class User < ApplicationRecord
          authenticates_with_sorcery!
          mount_uploader :avatar, AvatarUploader
        
          has_many :posts
          
          validates :email, presence: true, uniqueness: true
          validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
          validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
          validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
        end
        ```
        
    - `app/views/users/edit.html.erb` を作成し、プロフィール画像をアップロードするためのフォームを追加する
        - ラベルとフィールドの設定をすること
        
        ```html
        <div class="container mx-auto mt-8" style="width: 80%;">
          <h1 class="text-3xl font-bold mb-6 text-center">プロフィール編集</h1>
          <div class="bg-white shadow-md rounded-xl p-6">
            <%= form_with(model: @user, local: true, class: "space-y-4") do |form| %>
              <% if @user.errors.any? %>
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6">
                  <strong class="font-bold"><%= pluralize(@user.errors.count, "エラー") %>が発生しました:</strong>
                  <span class="block sm:inline"><%= @user.errors.full_messages.join(", ") %></span>
                </div>
              <% end %>
              <div>
                <%= form.label , "プロフィール画像", class: "block text-gray-700" %>
                <%= form.file_field , class: "mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" %>
              </div>
              <div class="text-center">
                <%= form.submit 'プロフィールを更新', class: "w-full bg-indigo-600 text-white py-2 px-4 rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2" %>
              </div>
            <% end %>
          </div>
        </div>
        ```
        
    - `app/views/layouts/_header.html.erb` にもプロフィール画像を表示するコードを追加すること
        
        ```
        <header class="bg-blue-500 p-4">
          <nav class="container mx-auto flex justify-between items-center">
            <%= link_to 'Top', root_path, class: "text-white font-semibold" %>
            <div class="flex items-center">
              <% if logged_in? %>
                <%= image_tag(画像を設定する, alt: "Avatar", class: "w-8 h-8 rounded-full bg-white mr-2") %>
                <%= link_to current_user.email, user_path(current_user), class: "text-white mx-2" %>
                <%= link_to 'New Post', new_post_path, class: "text-white mx-2" %>
                <%= button_to 'Logout', logout_path, method: :delete, class: "text-white mx-2 bg-transparent border-none cursor-pointer" %>
              <% else %>
                <%= link_to 'Sign Up', new_user_path, class: "text-white mx-2" %>
                <%= link_to 'Login', new_session_path, class: "text-white mx-2" %>
              <% end %>
            </div>
          </nav>
        </header>
        ```
        
- [ ]  プロフィール画像を表示するビューを作成
    - `app/views/users/show.html.erb` を編集し、プロフィール画像を表示するコードを追加すること
        
        ```html
        <div class="container mx-auto mt-8" style="width: 80%;">
          <div class="bg-white shadow-xl rounded-3xl p-8">
            <div class="flex items-center mb-6">
              <%= image_tag @user.avatar.url, alt: "Avatar", class: "w-24 h-24 rounded-full bg-gray-200 mr-4" %>
              <div>
                <h1 class="text-3xl font-bold"><%= @user.email %></h1>
                <p>登録日: <%= @user.created_at.strftime("%Y-%m-%d") %></p>
              </div>
            </div>
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
        
- [ ]  ルーティングの設定
    - プロフィール画像表示のためのルーティングを設定すること
- [ ]  確認
    - ブラウザでユーザー編集ページにアクセスし、プロフィール画像をアップロードできること