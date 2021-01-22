# frozen_string_literal: true

require "rails_helper"

describe "[STEP5] アクセス制限のテスト" do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:room) { create(:room, user: user) }
  let!(:other_room) { create(:room, user: other_user) }

  describe "ログインしていない場合のアクセス制限のテスト" do
    subject { current_path }

    it "マイページ" do
      visit edit_mypages_path
      is_expected.to eq new_user_session_path
    end
    it 'お問い合わせ' do
      visit new_contact_path
      is_expected.to eq new_user_session_path
    end
    it 'ルーム新規作成・検索' do
      visit new_room_path
      is_expected.to eq new_user_session_path
    end
    it 'メインページ' do
      visit main_path(room)
      is_expected.to eq new_user_session_path
    end
    it 'ルーム分析画面' do
      visit analysis_path(room)
      is_expected.to eq new_user_session_path
    end
    it "使い方" do
      visit how_to_path
      is_expected.to eq how_to_path
    end
  end

  describe "ログイン後のアクセス制限のテスト：ルーム新規作成" do
    before do
      visit new_user_session_path
      fill_in "user[name]", with: user.name
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      visit new_room_path
      fill_in "room[name]", with: room.name
      fill_in "room[goal]", with: room.goal
      fill_in "room[roompass]", with: room.roompass
      fill_in "room[roompass_confirmation]", with: room.roompass_confirmation
      click_on "ルームを作成"
      click_on "ログアウト"
      visit new_user_session_path
      fill_in "user[name]", with: other_user.name
      fill_in "user[email]", with: other_user.email
      fill_in "user[password]", with: other_user.password
      click_button "ログイン"
      visit new_room_path
      fill_in "room[name]", with: other_room.name
      fill_in "room[goal]", with: other_room.goal
      fill_in "room[roompass]", with: other_room.roompass
      fill_in "room[roompass_confirmation]", with: other_room.roompass_confirmation
      click_on "ルームを作成"
    end

    it "自分のメイン画面：成功" do
      visit main_path(other_room)
      expect(current_path).to eq main_path(Room.all.count)
    end
    it "他人のメイン画面：失敗" do
      visit main_path(room)
      expect(current_path).to eq main_path(Room.all.count)
    end
    it "他人のメイン画面：失敗のメッセージ" do
      visit main_path(room)
      expect(page).to have_content "他のルームに参加するためにはパスワードが必要です。"
    end
    it "自分のルーム分析画面：成功" do
      visit analysis_path(other_room)
      expect(current_path).to eq analysis_path(Room.all.count)
    end
    it "他人のルーム分析画面：失敗" do
      visit analysis_path(room)
      expect(current_path).to eq analysis_path(Room.all.count)
    end
    it "他人のルーム分析画面：失敗のメッセージ" do
      visit analysis_path(room)
      expect(page).to have_content "他のルームの分析画面は閲覧できません。"
    end
  end

  describe "ログイン後の分析アクセス制限のテスト：既存ルーム参加" do
    before do
      visit new_user_session_path
      fill_in "user[name]", with: user.name
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      visit new_room_path
      fill_in "room[name]", with: room.name
      fill_in "room[goal]", with: room.goal
      fill_in "room[roompass]", with: room.roompass
      fill_in "room[roompass_confirmation]", with: room.roompass_confirmation
      click_on "ルームを作成"
      click_on "ログアウト"
      visit new_user_session_path
      fill_in "user[name]", with: other_user.name
      fill_in "user[email]", with: other_user.email
      fill_in "user[password]", with: other_user.password
      click_button "ログイン"
      visit new_room_path
      fill_in "search_room", with: Room.all.count
      click_on "ルームを検索"
      fill_in "roomkey", with: room.roompass
      click_on "ルームに参加する"
    end

    it "他人が作成した参加中のルーム：成功" do
      visit analysis_path(room)
      expect(current_path).to eq analysis_path(Room.all.count)
    end
    it "ログアウト後の分析画面：2人のユーザー名が表示" do
      click_on "ログアウト"
      visit new_user_session_path
      fill_in "user[name]", with: user.name
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      visit analysis_path(room)
      expect(page).to have_content user.name
      expect(page).to have_content other_user.name
    end
  end

  describe "管理者のアクセス制限のテスト" do

    let(:admin) { create(:admin) }
    let(:contact) { create(:contact) }
    subject { current_path }

    it "ログインページ" do
      visit new_admin_session_path
      is_expected.to eq new_admin_session_path
    end
    it "新規登録ページ" do
      visit new_admin_registration_path
      is_expected.to raise_error(ActiveRecord::RecordNotFound)
    end
    it "お問い合わせ一覧ページ" do
      visit admins_contacts_path
      is_expected.to eq new_admin_session_path
    end
    it "お問い合わせ詳細ページ" do
      visit admins_contact_path(contact)
      is_expected.to eq new_admin_session_path
    end
    it "ルーム一覧ページ" do
    end
  end
end
