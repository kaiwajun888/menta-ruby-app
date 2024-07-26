## 環境構築

### リポジトリを fork する

<img width="1427" alt="スクリーンショット 2024-07-03 10 19 21" src="https://github.com/user-attachments/assets/40bc1411-d494-43f1-b13e-8bf010b5a836">

画面右上の「Fork」をクリックします

<img width="1429" alt="スクリーンショット 2024-07-03 10 24 16" src="https://github.com/user-attachments/assets/1ff41ebb-85e0-4bab-9baa-48370a457f5a">

「Create a new fork」画面が表示されます。以下項目を適宜入力・選択し、「Create fork」をクリックして下さい。

| 項目                             | 概要                                                                                                                                             |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| Owner                            | リポジトリの所有者を選択します。デフォルトでは自分自身のアカウント名が表示されているので、そのままでかまいません。                               |
| Repository name                  | フォークしたリポジトリの名前を付けます。デフォルトで表示されているのは、フォーク元のリポジトリ名です。特に問題なければそのままでもかまいません。 |
| Description                      | フォークに関する説明を任意で入力します。デフォルトで表示されているのは、フォーク元の説明です。特に問題なければそのままでもかまいません。         |
| Copy the main branch only        | このチェックを外すと全てのブランチがコピーされます。                                                                                             |
| 今回はチェックを外してください。 |

### fork したリポジトリを clone する

フォークしたリポジトリを、ローカルの PC へクローン（コピー）して編集できるようにしましょう。

<img width="1428" alt="スクリーンショット 2024-07-03 10 34 46" src="https://github.com/user-attachments/assets/dc285818-0c2a-4869-bcf2-57949f8c9500">

フォークしたリポジトリで`Code`をクリック

リポジトリの URL が表示されるので、URL 欄の横にあるコピーボタンをクリック

ターミナル（端末）などを開いて、リポジトリを配置したい階層まで cd コマンドで移動する

リポジトリを clone する

```ruby
git clone 【クローン先のURL】

// 多分下記のようになると思いますので、実行してください
git clone [git@github.com](mailto:git@github.com):Kaiwa-Jun/menta-ruby-app.git
```

## PR 作成を Slack で通知する設定

PR の作成やレビューコメントをした際に Slack で通知されるようにします

1. 下記から Github App のインストールする

https://github.com/apps/slack

1. 下の画像の`Only select repositories`を選択し、`Select repositories`をクリック
2. `menta-ruby-app`を選択する
3. save をクリック

![スクリーンショット 2024-07-23 22 50 08](https://github.com/user-attachments/assets/6b500ddf-b98b-4b93-bd38-a37d4638ffb9)


**※ここまでできたら、リポジトリの URL を Slack で共有してください**

```
※鹿岩がやる操作
/github subscribe list features
/github subscribe owner/repository comments,pulls
/github unsubscribe owner/repository issues,commits,releases,deployments
```

### リポジトリへのアクセス権限の設定をする

1. 下記 URL を参考にして’[Kaiwa-Jun](https://github.com/Kaiwa-Jun)’をコラボレーターとして設定してください

https://docs.github.com/ja/repositories/managing-your-repositorys-settings-and-features/managing-repository-settings/managing-teams-and-people-with-access-to-your-repository#inviting-a-team-or-person

## 完成状態を確認する

clone ができたらまずは完成状態を確認しましょう！

```ruby
cd menta-ruby-app
git branch // developブランチであることを確認
docker-compose build
docker-compose up
```

ブラウザで`http://localhost:3000/`にアクセスする

エラー画面が表示されますが、`Create database`をクリックすれば OK です

<img width="1428" alt="スクリーンショット 2024-07-03 9 15 18" src="https://github.com/user-attachments/assets/377ff927-d39e-4e5b-bfd3-d8da074e1fec">

画面の確認(完成品)

どんな機能あるか動かしてみてください

### ブランチを切り替えて課題をスタートする

```ruby

git fetch -all
git branch -a
* develop
  remotes/origin/HEAD -> origin/develop
  remotes/origin/develop
  remotes/origin/feature1/skip-unnecessary-files
  remotes/origin/feature2/setup-routes
  .
  .
  .
```

```ruby
# baseブランチにチェックアウトする（このbaseブランチに成果物が集約されていきます）
git checkout -b base origin/base

# 課題１（feature1/skip-unnecessary-files）にブランチを切り替える例
git checkout -b feature1/skip-unnecessary-files

# feature1/skip-unnecessary-filesに切り替わっているか確認
git branch
  develop
* feature1/skip-unnecessary-files
```

各課題の番号ごとに README.md があります。課題 1 の場合は README1.md です。

README1.md の指示（チェックボックス）を実装していく

### プルリクエストを作成する

実装が完了したら、プルリクエストを作成します

1. ブランチの変更をコミットする

```
git add .
git commit -m "不必要なファイルの生成を避ける設定" ←自分で分かればなんでもいいです
```

1. リモートリポジトリにプッシュする

```
git push origin feature1/skip-unnecessary-files
```

1. GitHub のリポジトリページで PR を作成する

   1. リポジトリページの上部にある`Compare&Pull request`をクリック
   2. 下記のようなフォーマットで PR を作成

      (今後の開発現場で PR を作成できるように下記のように作成してみましょう！)

```
# 概要
例：投稿の削除機能を実装しました
例：投稿の編集時に編集時刻が反映されないバグの修正をしました

# 再現手順
削除機能の例
1. 投稿一覧画面（http://localhost:3000/posts）に遷移
2. 任意の投稿の削除アイコンをクリック
3. 削除確認のモーダルが表示される
4. 「削除」ボタンをクリック

# 期待する動作
「削除」ボタンをクリック後、投稿一覧画面（http://localhost:3000/posts）に自動で遷移し、対象の投稿が削除されること

# 動作環境
必要に応じて書く
例：管理者権限でログインしておくこと
例：ログイン状態でのみ削除されること
```

1. 開発したブランチから base ブランチにマージされるように設定する
   1. 画面左上が`ご自身のリポジトリ`であることを確認する
   2. マージ先が`base`となっていることを確認する
   3. 上記フォーマットで PR の内容を記述する
   4. `Create pull request`をクリックで PR が作成されます

![スクリーンショット 2024-07-24 1 06 43](https://github.com/user-attachments/assets/30399907-eb8b-4052-b257-2ceddf661153)

PR を私が確認して OK であれば base へマージされます

### マージされたらローカルの base ブランチを最新にしましょう

実際の開発現場では、`開発 → PR → baseへのマージ`が各開発者ごとに行われます

なので、他の開発者が行ったコードの変更がリモートの base ブランチに集約されていきます

リモートの base ブランチとローカルの base ブランチに差異が出てしまうため、定期的にローカルの base を最新にしましょう

```ruby
git checkout base
git pull
```

### 実装中のコードも定期的に最新にしましょう

例えば、、、
```
step1：実装完了して、PR のレビュー待ち
step2：実装途中
base：step1 がレビュー中なので step1 はマージされていない
```
この後、step2 の実装途中に step1 のレビューが終わり、base ブランチに step1 の内容がマージされたとします

ここで step2 の内容を step1 の実装内容を取り込んだものにしたいと考えます

手順としては下記になります

```ruby
# baseブランチを最新にする（baseをstep1を取り込んだ状態にする）
git checkout base
git pull

# step2にstep1を取り込んだ状態のbaseブランチを取り込む
git checkout step2 　←ブランチ名は簡略化してます

git merge base
or
git rebase base
```

### スタイルの反映

TailwindCSS でのスタイリングがなぜか下記コマンドを実行しないと反映されない状態です

今後解消したいと思いますが、一旦下記コマンドで対応してください

```
docker-compose exec web yarn run build:css
```
