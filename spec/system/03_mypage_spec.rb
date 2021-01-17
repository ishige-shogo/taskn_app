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
      edit_mypages_path
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

    end

  end
end

