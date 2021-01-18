# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room, "Roomモデルに関するテスト", type: :model do
  describe "実際に保存する" do
    it "有効なルーム新規作成の場合は保存されるか" do
      expect(FactoryBot.build(:room)).to be_valid
    end
  end

  describe "空白のバリデーションテスト" do
    subject { room.valid? }

    let(:user) { create(:user) }
    let!(:room) { build(:room, user_id: user.id) }

    context "nameカラム" do
      it "空欄でないこと" do
        room.name = ""
        is_expected.to eq false
      end
      it "20文字以内であること：20文字はo" do
        room.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it "20文字以内であること：21文字はx" do
        room.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context "goalカラム" do
      it "空欄でも保存されること" do
        room.goal = ""
        is_expected.to eq true
      end
    end

    context "roompassカラム" do
      it "空欄でないこと" do
        room.roompass = ""
        room.roompass_confirmation = ""
        is_expected.to eq false
      end
      it "3文字以上であること：2文字はx" do
        room.roompass = Faker::Lorem.characters(number: 2)
        room.roompass_confirmation = room.roompass
        is_expected.to eq false
      end
      it "3文字以上であること：3文字はo" do
        room.roompass = Faker::Lorem.characters(number: 3)
        room.roompass_confirmation = room.roompass
        is_expected.to eq true
      end
      it "20文字以内であること：20文字はo" do
        room.roompass = Faker::Lorem.characters(number: 20)
        room.roompass_confirmation = room.roompass
        is_expected.to eq true
      end
      it "20文字以上であること：21文字はx" do
        room.roompass = Faker::Lorem.characters(number: 21)
        room.roompass_confirmation = room.roompass
        is_expected.to eq false
      end
      it "再入力と値が異なっていた時に作成されないこと" do
        room.roompass = Faker::Lorem.characters(number: 10)
        room.roompass_confirmation = Faker::Lorem.characters(number: 11)
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1となっている" do
        expect(Room.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context "Memoモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:memos).macro).to eq :has_many
      end
    end

    context "Taskモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:tasks).macro).to eq :has_many
      end
    end
  end
end
