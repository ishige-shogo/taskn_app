# frozen_string_literal: true

require "rails_helper"

describe "[STEP2] ログイン後：お問い合わせ機能のテスト" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:contact) { create(:contact, user: user) }
  let!(:other_contact) { create(:contact, user: other_user)}

  before do
    visit new_user_session_path
    fill_in "user[name]", with: user.name
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    click_button "ログイン"
  end

  describe "ヘッダーのテスト：ログイン状態" do
    context "リンクの内容の確認" do
      it "「お問い合わせ」を押すと遷移する" do
        click_on "お問い合わせ"
        expect(current_path).to eq new_contact_path
      end
    end
  end

  describe "送信のテスト" do
    before do
      visit new_contact_path
    end
    context "フォームに値が入ってない" do
      it 'タイトルに値が入っていない' do
        expect(find_field('contact[title]').text).to be_blank
      end
      it '本文に値が入ってない' do
        expect(find_field('contact[body]').text).to be_blank
      end
    end

    context "投稿成功のテスト" do
      before do
        fill_in "contact[title]", with: contact.title
        fill_in "contact[body]", with: contact.body
      end

      it "成功のメッセージが表示される" do
        click_on "お問い合わせを作成"
        expect(page).to have_content "お問い合わせが送信されました。"
      end
      it "投稿が正しく保存される" do
        expect { click_button "お問い合わせを作成" }.to change(user.contacts, :count).by(1)
      end
      it "遷移先がお問い合わせ一覧になっている" do
        click_on "お問い合わせを作成"
        expect(current_path).to eq new_contact_path
      end
      it "投稿内容が正しく表示されるか" do
        click_on "お問い合わせを作成"
        expect(page).to have_content contact.title
        expect(page).to have_content contact.body[0..9]
        expect(page).to have_content "未読"
      end
      it "フォームに値が入っていない" do
        click_on "お問い合わせを作成"
        expect(find_field('contact[title]').text).to be_blank
        expect(find_field('contact[body]').text).to be_blank
      end
    end

    context "投稿失敗のテスト" do
      it "エラーメッセージが表示される" do
        fill_in "contact[title]", with: ""
        fill_in "contact[body]", with: ""
        click_on "お問い合わせを作成"
        expect(page).to have_content "タイトル・お問い合わせ内容を確認してください。"
      end
    end
  end

  describe "その他のテスト：他人の送信" do
    before do
      visit new_contact_path
      fill_in "contact[title]", with: contact.title
      fill_in "contact[body]", with: contact.body
      click_on "お問い合わせを作成"
      click_on "ログアウト"
      visit new_user_session_path
      fill_in "user[name]", with: other_user.name
      fill_in "user[email]", with: other_user.email
      fill_in "user[password]", with: other_user.password
      click_button "ログイン"
      visit new_contact_path
    end

    context "フォームに値が入ってない" do
      it 'タイトルに値が入っていない' do
        expect(find_field('contact[title]').text).to be_blank
      end
      it '本文に値が入ってない' do
        expect(find_field('contact[body]').text).to be_blank
      end
    end

    context "他人の投稿が表示されていない" do
      it "他人の投稿が表示されていない" do
        expect(page).not_to have_content contact.title
        expect(page).not_to have_content contact.body[0..9] + "..."
      end
    end

    context "自分の投稿は表示される" do
      before do
        fill_in "contact[title]", with: other_contact.title
        fill_in "contact[body]", with: other_contact.body
      end

      it "自分の投稿は保存される" do
        expect { click_button "お問い合わせを作成" }.to change(other_user.contacts, :count).by(1)
      end
      it "投稿内容が正しく表示されるか" do
        click_on "お問い合わせを作成"
        expect(page).to have_content other_contact.title
        expect(page).to have_content other_contact.body[0..9]
        expect(page).to have_content "未読"
      end
      it "再度のログインで他人の投稿が表示されない" do
        click_on "お問い合わせを作成"
        click_on "ログアウト"
        visit new_user_session_path
        fill_in "user[name]", with: user.name
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
        click_button "ログイン"
        visit new_contact_path
        expect(page).to have_content contact.title
        expect(page).to have_content contact.body[0..9] + "..."
        expect(page).not_to have_content other_contact.title
        expect(page).not_to have_content other_contact.body[0..9] + "..."
      end
    end
  end
end
