# frozen_string_literal: true

require "rails_helper"

describe "[STEP1] ユーザーログイン前のテスト" do
  describe "トップ画面のテスト" do
    before do
      visit root_path
    end

    context "表示内容の確認" do
      it "URLがルートパスになっている" do
        expect(current_path).to eq "/"
      end
      it "タイトルが表示される" do
        expect(page).to have_css '.logo-image'
      end
      it "使い方リンクが表示される" do
        expect(page).to have_link "使い方"
      end
      it "使い方リンクの内容が正しい" do
        click_on "使い方"
        expect(current_path).to eq how_to_path
      end
      it "ログインリンクが表示される" do
        expect(page).to have_link "ログイン"
      end
      it "ログインリンクの内容が正しい" do
        click_on "ログイン"
        expect(current_path).to eq new_user_session_path
      end
      it "アカウント作成リンクが表示さいる" do
        expect(page).to have_link "アカウント作成"
      end
      it "アカウント作成リンクの内容が正しい" do
        click_on "アカウント作成"
        expect(current_path).to eq new_user_registration_path
      end
      it "ゲストログインリンクが表示される" do
        expect(page).to have_link "ゲストログイン"
      end
      it "ゲストログインリンクの内容が正しい" do
        click_on "ゲストログイン"
        expect(current_path).to eq how_to_path
      end
    end
  end

  describe "使い方画面の確認" do
    describe "使い方画面のテスト" do
      before do
        visit how_to_path
      end

      context "表示内容の確認" do
        it "URLが正しい" do
          expect(current_path).to eq "/how_to"
        end
      end
    end
  end

  describe "ユーザー新規登録のテスト" do
    before do
      visit new_user_registration_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/users/sign_up"
      end
      it "「アカウント作成」と表示される" do
        expect(page).to have_content "アカウント作成"
      end
      it "nameフォームが表示される" do
        expect(page).to have_field "user[name]"
      end
      it "emailフォームが表示される" do
        expect(page).to have_field "user[email]"
      end
      it "passwordフォームが表示される" do
        expect(page).to have_field "user[password]"
      end
      it "password_confirmationフォームが表示される" do
        expect(page).to have_field "user[password_confirmation]"
      end
      it "アカウント作成ボタンが表示される" do
        expect(page).to have_button "アカウントを作成"
      end
      it "ログインボタンが表示される" do
        expect(page).to have_button "ログイン"
      end
      it "ゲストログインボタンが表示される" do
        expect(page).to have_button "ゲストログイン"
      end
    end

    context "アカウント作成成功のテスト" do
      before do
        fill_in "user[name]", with: Faker::Lorem.characters(number: 10)
        fill_in "user[email]", with: Faker::Internet.email
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
      end

      it "正しくアカウント作成される" do
        expect { click_button "アカウントを作成" }.to change(User.all, :count).by(1)
      end
      it "アカウント作成後の遷移先が、使い方画面になっている" do
        click_button "アカウントを作成"
        expect(current_path).to eq how_to_path
      end
    end
  end

  describe "ユーザーログインのテスト" do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/users/sign_up"
      end
      it "「アカウント作成」と表示される" do
        expect(page).to have_content "アカウント作成"
      end
      it "nameフォームが表示される" do
        expect(page).to have_field "user[name]"
      end
      it "emailフォームが表示される" do
        expect(page).to have_field "user[email]"
      end
      it "passwordフォームが表示される" do
        expect(page).to have_field "user[password]"
      end
      it "password_confirmationフォームが表示される" do
        expect(page).not_to have_field "user[password_confirmation]"
      end
      it "アカウント作成ボタンが表示される" do
        expect(page).to have_button "アカウントを作成"
      end
      it "ログインボタンが表示される" do
        expect(page).to have_button "ログイン"
      end
      it "ゲストログインボタンが表示される" do
        expect(page).to have_button "ゲストログイン"
      end
    end

    context "ログイン成功のテスト" do
      before do
        fill_in "user[name]", with: user.name
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
        click_button "ログイン"
      end

      it "ログイン後の遷移先が、ログインしたユーザーのマイページになっている" do
        expect(current_path).to eq "/mypages/edit"
      end
      it "ログイン後の遷移先が、ログインしたユーザーのマイページになっている" do
        expect(current_path).to have_content user.name
      end
    end

    context "ログイン失敗のテスト" do
      before do
        fill_in "user[name]", with: ""
        fill_in "user[email]", with: ""
        fill_in "user[password]", with: ""
        click_button "ログイン"
      end

      it "ログインに失敗し、ログイン画面にリダイレクトされる" do
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe "ヘッダーのテスト：ログイン時" do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in "user[name]", with: user.name
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
    end

    context "ヘッダーの表示を確認" do
      it "タイトルが表示される" do
        expect(page).to have_css '.logo-image'
      end
      it "「ルーム作成・検索」が表示される" do
        expect(page).to have_link "ルーム作成・検索"
      end
      it "「ユーザーさんのマイページ」が表示される" do
        expect(page).to have_link user.name + "さんのマイページ"
      end
      it "「お問い合わせ」が表示される" do
        expect(page).to have_link "お問い合わせ"
      end
      it "「使い方」が表示される" do
        expect(page).to have_link "使い方"
      end
    end
  end

  describe "ユーザーログアウトのテスト" do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in "user[name]", with: user.name
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      click_on "ログアウト"
    end

    context "ログアウトのテスト" do
      it "遷移先がトップ画面になっている" do
        expect(current_path).to eq "/"
      end
    end

    context "ログアウト後のヘッダーのテスト" do
      it "タイトルが表示される" do
        expect(page).to have_css '.logo-image'
      end
      it "使い方リンクが表示される" do
        expect(page).to have_link "使い方"
      end
      it "ログインリンクが表示される" do
        expect(page).to have_link "ログイン"
      end
      it "アカウント作成リンクが表示さいる" do
        expect(page).to have_link "アカウント作成"
      end
      it "ゲストログインリンクが表示される" do
        expect(page).to have_link "ゲストログイン"
      end
    end
  end
end
