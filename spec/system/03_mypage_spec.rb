# frozen_string_literal: true

require "rails_helper"

describe "[STEP3] ログイン後：マイページのテスト" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in "user[name]", with: user.name
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    click_button "ログイン"
  end

  describe "ヘッダーのテスト：ログイン状態" do
    context "リンクの内容の確認" do
      it "「マイページ」を押すと遷移する" do
        click_on "#{user.name}さんのマイページ"
        expect(current_path).to eq edit_mypages_path
      end
    end
  end

  describe "編集のテスト" do
    before do
      visit edit_mypages_path
    end

    context "フォームの値の内容" do
      it "ニックネームのフォームにユーザー名が入っている" do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it "メールアドレスのフォームにユーザー名が入っている" do
        expect(page).to have_field 'user[email]', with: user.email
      end
    end

    context "編集成功のテスト" do
      before do
        @old_user_name = user.name
        @old_user_email = user.email
        @new_user_name = Faker::Lorem.characters(number: 5)
        @new_user_email = Faker::Internet.email
        fill_in "user[name]", with: @new_user_name
        fill_in "user[email]", with: @new_user_email
        click_on "変更を保存"
      end

      it "ニックネームが変更保存されている" do
        expect(user.reload.name).not_to eq @old_user_name
      end
      it "ニックネームのフォームに新しいユーザー名が入っている" do
        expect(page).to have_field 'user[name]', with: @new_user_name
      end
      it "メールアドレスが変更保存されている" do
        expect(user.reload.email).not_to eq @old_user_email
      end
      it "メールアドレスのフォームに新しいメールアドレスが入っている" do
        expect(page).to have_field 'user[email]', with: @new_user_email
      end
      it "成功のメッセージが表示される" do
        expect(page).to have_content "ユーザー情報が変更されました。"
      end
      it "遷移先がマイページになっている" do
        expect(current_path).to eq "/mypages/edit." + user.id.to_s
      end
    end

    context "編集失敗のテスト" do
      before do
        fill_in "user[name]", with: ""
        fill_in "user[email]", with: ""
        click_on "変更を保存"
      end

      it "エラーメッセージが表示される" do
        expect(page).to have_content "ニックネーム・メールアドレスを確認してください。(すでに使用されているメールアドレスは別アカウントに登録できません)"
      end
      it "変更が保存されていない" do
        click_on "使い方"
        click_on "#{user.name}さんのマイページ"
        expect(page).not_to have_content "ニックネーム・メールアドレスを確認してください。(すでに使用されているメールアドレスは別アカウントに登録できません)"
        expect(page).to have_field 'user[name]', with: user.name
        expect(page).to have_field 'user[email]', with: user.email
      end
    end
  end

  describe "パスワードの変更" do
    before do
      @old_user_password = user.password
      @new_user_password = Faker::Lorem.characters(number: 10)
      visit edit_mypages_path
      click_on "パスワードを変更する"
    end

    it "リンクのテスト：パスワード変更画面" do
      expect(current_path).to eq "/users/edit"
    end
    it "リンクのテスト：マイページに戻る" do
      click_on "マイページに戻る"
      expect(current_path).to eq "/mypages/edit." + user.id.to_s
    end
    it "成功のテスト" do
      fill_in "user[current_password]", with: @old_user_password
      fill_in "user[password]", with: @new_user_password
      fill_in "user[password_confirmation]", with: @new_user_password
      click_on "パスワードを変更する"
      expect(current_path).to eq root_path
    end
    it "失敗のテスト" do
      fill_in "user[current_password]", with: @new_user_password
      fill_in "user[password]", with: @new_user_password
      fill_in "user[password_confirmation]", with: @new_user_password
      click_on "パスワードを変更する"
      expect(current_path).not_to eq root_path
    end
  end

  describe "編集後のログインテスト" do
    before do
      @old_user_name = user.name
      @old_user_email = user.email
      @old_user_password = user.password
      @new_user_name = Faker::Lorem.characters(number: 5)
      @new_user_email = Faker::Internet.email
      @new_user_password = Faker::Lorem.characters(number: 10)
      visit edit_mypages_path
    end

    context "ニックネームの変更" do
      it "新しいニックネームでのログインの成功" do
        fill_in "user[name]", with: @new_user_name
        click_on "変更を保存"
        click_on "ログアウト"
        visit new_user_session_path
        fill_in "user[name]", with: @new_user_name
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
        click_button "ログイン"
        expect(current_path).to eq "/mypages/edit." + user.id.to_s
      end
      it "古いニックネームでのログインの失敗" do
        fill_in "user[name]", with: @new_user_name
        click_on "変更を保存"
        click_on "ログアウト"
        visit new_user_session_path
        fill_in "user[name]", with: @old_user_name
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
        click_button "ログイン"
        expect(current_path).to eq new_user_session_path
      end
    end

    context "メールアドレスの変更" do
      it "新しいメールアドレスでのログインの成功" do
        fill_in "user[email]", with: @new_user_email
        click_on "変更を保存"
        click_on "ログアウト"
        visit new_user_session_path
        fill_in "user[name]", with: user.name
        fill_in "user[email]", with: @new_user_email
        fill_in "user[password]", with: user.password
        click_button "ログイン"
        expect(current_path).to eq "/mypages/edit." + user.id.to_s
      end
      it "古いメールアドレスでのログインの失敗" do
        fill_in "user[email]", with: @new_user_email
        click_on "変更を保存"
        click_on "ログアウト"
        visit new_user_session_path
        fill_in "user[name]", with: user.name
        fill_in "user[email]", with: @old_user_email
        fill_in "user[password]", with: user.password
        click_button "ログイン"
        expect(current_path).to eq new_user_session_path
      end
    end

    context "パスワードの変更" do
      it "新しいパスワードでのログインの成功" do
        click_on "パスワードを変更する"
        fill_in "user[current_password]", with: @old_user_password
        fill_in "user[password]", with: @new_user_password
        fill_in "user[password_confirmation]", with: @new_user_password
        click_on "パスワードを変更する"
        click_on "ログアウト"
        visit new_user_session_path
        fill_in "user[name]", with: user.name
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: @new_user_password
        click_button "ログイン"
        expect(current_path).to eq "/mypages/edit." + user.id.to_s
      end
      it "古いパスワードでのログインの失敗" do
        click_on "パスワードを変更する"
        fill_in "user[current_password]", with: @old_user_password
        fill_in "user[password]", with: @new_user_password
        fill_in "user[password_confirmation]", with: @new_user_password
        click_on "パスワードを変更する"
        click_on "ログアウト"
        visit new_user_session_path
        fill_in "user[name]", with: user.name
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: @old_user_password
        click_button "ログイン"
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe "退会処理" do
    before do
      visit edit_mypages_path
    end

    it "退会確認：リンクの遷移" do
      click_on "退会する"
      expect(current_path).to eq "/mypages/unsubscribe"
    end
    it "マイページに戻る：リンクの遷移" do
      click_on "退会する"
      click_on "マイページに戻る"
      expect(current_path).to eq "/mypages/edit." + user.id.to_s
    end
    it "退会後：リンクの遷移" do
      click_on "退会する"
      click_on "退会する"
      expect(current_path).to eq root_path
    end
    it "退会後のログイン" do
      click_on "退会する"
      click_on "退会する"
      visit new_user_session_path
      fill_in "user[name]", with: user.name
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content "このアカウントは利用できません。"
    end
    it "退会後、他のユーザーのログイン" do
      click_on "退会する"
      click_on "退会する"
      visit new_user_session_path
      fill_in "user[name]", with: other_user.name
      fill_in "user[email]", with: other_user.email
      fill_in "user[password]", with: other_user.password
      click_button "ログイン"
      expect(current_path).to eq "/mypages/edit." + other_user.id.to_s
    end
  end
end
