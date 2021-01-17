# frozen_string_literal: true

require "rails_helper"

describe "[STEP4] ログイン後：ルームのテスト" do
  let(:user) { create(:user) }
  let(:other1_user) { create(:user) }
  let(:other2_user) { create(:user) }
  let!(:room) { create(:room) }
  let!(:other_room) { create(:room) }

  before do
    visit new_user_session_path
    fill_in "user[name]", with: user.name
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    click_button "ログイン"
  end

  describe "ヘッダーのテスト：ログイン状態" do
    context "リンクの内容の確認" do
      it "「ルーム作成・検索」を押すと遷移する" do
        click_on "ルーム作成・検索"
        expect(current_path).to eq new_room_path
      end
    end
  end

  describe "ルームの新規作成のテスト" do
    before do
      visit new_room_path
    end
    context "フォームの値の内容" do
      it 'ルーム名に値が入っていない' do
        expect(find_field('room[name]').text).to be_blank
      end
      it 'ルームの目標に値が入ってない' do
        expect(find_field('room[goal]').text).to be_blank
      end
      it 'ルームパスワードに値が入っていない' do
        expect(find_field('room[roompass]').text).to be_blank
      end
      it 'ルームパスワード(再入力)に値が入っていない' do
        expect(find_field('room[roompass_confirmation]').text).to be_blank
      end
    end

    context "ルームの新規作成の成功" do
      before do
        fill_in "room[name]", with: room.name
        fill_in "room[goal]", with: room.goal
        fill_in "room[roompass]", with: room.roompass
        fill_in "room[roompass_confirmation]", with: room.roompass_confirmation
      end
      it "ルームが新しく保存される" do
        expect { click_button "ルームを作成" }.to change(user.rooms, :count).by(1)
      end
      it "作成後の遷移先が正しい" do
        click_on "ルームを作成"
        expect(current_path).to eq main_path(room.last.id)
      end
      it "成功のメッセージが表示される" do
        click_on "ルームを作成"
        expect(page).to have_content "ルームを新しく作成しました。"
      end
      it "ルーム名/ID/目標が表示される" do
        click_on "ルームを作成"
        expect(page).to have_content room.last.id
        expect(page).to have_content room.name
        expect(page).to have_content room.goal
      end
    end
  end

end

