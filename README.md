# タスクん

## サイト概要
**チームで利用できるTODOリスト管理アプリケーション**です。<br>
**ルームはパスワード管理**されており、チーム以外の人は閲覧編集ができません。<br>
また**掲示板メモ機能・分析機能**も搭載しており、利用者はタスクの進捗度を、管理者は登録人数や累計ルーム数のデータを**グラフによって可視化**できます。

## サイトテーマ
チームで利用できるTODOリスト管理アプリケーションです。

## テーマを選んだ理由
チームでのアプリケーション開発を経験した上で、**不便だと感じた部分を解消できるアプリ**を作成したいと思いました。

以下が不便に感じた部分とその解決方法(本アプリケーションの仕様)です。

* AWS・Slack・Googleスプレッドシート・drawioと多くの画面を見ながら進めていましたが、**画面の切替にストレスを感じていました。**
    * TODOリスト・掲示板メモを1画面に表示し、またメモの新規作成や削除を同じページで行えるようにすることでページの遷移を減らします。

* チーム会議でやるべきことを決めましたが、**どこから手を付ければいいか分からない**ときがありました。
  * TODOリストに優先度を設定できるので、手を付ける順番に迷いません。

* **他のメンバーのタスク進行状況が分からない**ときがありました。
  * 実行中や実行済のタスクを表示させることで、他のメンバーの状況を可視化できるようにします。

* メンバーの連絡事項を確認する際、**チャットを遡らないといけないのが面倒**でした。
  * TODOリストと同じページに常に表示している掲示板メモをつけます。(編集・削除・一括削除が可能です)

* **全体のタスク進捗度**が時々分からなくなりました。
  * 分析ページでは終了したタスクを一覧表示させ、またチーム全体のタスク達成率をグラフで表示します。

## ターゲットユーザ
+ **チームで何かタスクをこなす必要がある人**(アプリ開発・アルバイトの勤怠管理・大学の新歓買い出し準備等)

+ **個人で何か目標がある人**(アプリ開発・英語学習・やりたいことリスト等)

## 主な機能と使い方
+ **TODOリスト・掲示板メモを1画面に表示すること**でUIの向上に努めています。

+ 分析機能を搭載し、**タスクの進捗度をグラフで可視化できます。**

+ **ルームにパスワードを設定**することで、チーム以外の利用者には内容を見られません。

**1. チームで利用するとき（アプリケーション開発）**

>+ TODOリストにタスクを追加します。
>+ タスクを担当するときは担当するボタンを押し、終わったときは終了ボタンを押します。(担当した人とタスク内容は保存されます)
>+ 掲示板メモ機能では画面に常に表示させたいことを記述します。(本日15時～会議です・10時～11時まで不在です　等)
>+ 分析画面でタスクの進捗状況を確認できます。(全体のタスク進捗度・個人の担当したタスク　等)


**2. 個人で利用するとき（やりたいことリスト）**

>+ TODOリストにやりたいこと(タスク)を追加します。
>+ こなしたタスクの終了ボタンを押します。（タスク内容は保存されます）
>+ 掲示板メモ機能では忘れてはいけない内容やタスク記述ルールを書きます。(本日14-16時に配達物受け取り予定・現実的なものだけ記述すること　等)
>+ 分析画面でタスク達成度を確認できます。


## 設計書

[ER図・UIFlow・画面設計](https://docs.google.com/presentation/d/1eZgJde1nMYudyUOFiBr0TFLnuX0U71qg0qFNmT0f-UY/edit?usp=sharing)（Googleスライドに遷移します）

[テーブル定義書・アプリケーション詳細設計](https://docs.google.com/spreadsheets/d/1T74wFeck5zvVcDJOU_7VzCvwDMPfgS-o02Bh9Bzpbiw/edit?usp=sharing)（Googleスプレッドシートに遷移します）

## 機能一覧
[機能一覧](https://docs.google.com/spreadsheets/d/1RFY9YETr8O3dOyvynmOLHyf9Lk7-TYPbuJRNSd9cFK0/edit?usp=sharing)（Googleスプレッドシートに遷移します）

## 開発環境
+ OS：Windows10
+ 言語：Ruby,HTML,CSS,JavaScript
+ フレームワーク：Ruby on Rails 5.2.4
+ JSライブラリ：jQuery
+ IDE：AWS Cloud9

## 使用素材
+ [ICOOON  MONO](https://icooon-mono.com/category/transport/)（ヘッダーアイコン・利用者アイコンに使用）

+ [Canva](https://www.canva.com/)（アプリケーションのロゴ・トップページ・アバウトページに使用）

