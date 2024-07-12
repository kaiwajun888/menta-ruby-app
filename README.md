## 環境構築

### リポジトリをforkする

<img width="1427" alt="スクリーンショット 2024-07-03 10 19 21" src="https://github.com/user-attachments/assets/40bc1411-d494-43f1-b13e-8bf010b5a836">

画面右上の「Fork」をクリックします

<img width="1429" alt="スクリーンショット 2024-07-03 10 24 16" src="https://github.com/user-attachments/assets/1ff41ebb-85e0-4bab-9baa-48370a457f5a">

「Create a new fork」画面が表示されます。以下項目を適宜入力・選択し、「Create fork」をクリックして下さい。

| 項目 | 概要 |
| --- | --- |
| Owner | リポジトリの所有者を選択します。デフォルトでは自分自身のアカウント名が表示されているので、そのままでかまいません。 |
| Repository name | フォークしたリポジトリの名前を付けます。デフォルトで表示されているのは、フォーク元のリポジトリ名です。特に問題なければそのままでもかまいません。 |
| Description | フォークに関する説明を任意で入力します。デフォルトで表示されているのは、フォーク元の説明です。特に問題なければそのままでもかまいません。 |
| Copy the main branch only | このチェックを外すと全てのブランチがコピーされます。
今回はチェックを外してください。 |

### forkしたリポジトリをcloneする

フォークしたリポジトリを、ローカルのPCへクローン（コピー）して編集できるようにしましょう。

<img width="1428" alt="スクリーンショット 2024-07-03 10 34 46" src="https://github.com/user-attachments/assets/dc285818-0c2a-4869-bcf2-57949f8c9500">

フォークしたリポジトリで`Code`をクリック

リポジトリのURLが表示されるので、URL欄の横にあるコピーボタンをクリック

ターミナル（端末）などを開いて、リポジトリを配置したい階層までcdコマンドで移動する

リポジトリをcloneする

```ruby
git clone 【クローン先のURL】

// 多分下記のようになると思いますので、実行してください
git clone [git@github.com](mailto:git@github.com):Kaiwa-Jun/menta-ruby-app.git
```

## 完成状態を確認する

cloneができたらまずは完成状態を確認しましょう！

```ruby
cd menta-ruby-app
git branch // developブランチであることを確認
docker-compose build
docker-compose up
```

ブラウザで`http://localhost:3001/`にアクセスする

エラー画面が表示されますが、`Create database`をクリックすればOKです

<img width="1428" alt="スクリーンショット 2024-07-03 9 15 18" src="https://github.com/user-attachments/assets/377ff927-d39e-4e5b-bfd3-d8da074e1fec">

画面の確認(完成品)

どんな機能あるかの説明、動かしてみてって書く

### ブランチを切り替えて課題をスタートする

（もしかしたら違うかも）

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
# 課題１（feature1/skip-unnecessary-files）にブランチを切り替える例
git checkout -b feature1/skip-unnecessary-files origin/feature1/skip-unnecessary-files

# feature1/skip-unnecessary-filesに切り替わっているか確認
git branch
  develop
* feature1/skip-unnecessary-files
```

各課題の番号ごとにREADME.mdがあります。課題1の場合はREADME1.mdです。

README1.mdの指示（チェックボックス）を実装していく

実装完了したら、Pull Requestを作成する

OKであれば、私の方でdevelopブランチへマージします

### マージされたらローカルのdevelopブランチを最新にしましょう

実際の開発現場では、`開発 → PR → developへのマージ`が各開発者ごとに行われます

なので、他の開発者が行ったコードの変更がリモートのdevelopブランチに集約されていきます

リモートのdevelopブランチとローカルのdevelopブランチに差異が出てしまうため、定期的にローカルのdevelopを最新にしましょう

```
git checkout develop
git pull
```
