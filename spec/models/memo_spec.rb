# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Memo, "Memoモデルに関するテスト", type: :model do

  describe "実際に保存する" do
    it "有効なメモ新規作成の場合は保存されるか" do
      expect(FactoryBot.build(:memo)).to be_valid
    end
  end

  describe "空白のバリデーションテスト" do
    subject { memo.valid? }

    let(:user) { create(:user) }
    let(:room) { create(:room) }
    let!(:memo) { build(:memo, user_id: user.id, room_id: room.id) }

    context "bodyカラム" do
      it "空欄でないこと" do
        memo.body = ""
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1となっている" do
        expect(Memo.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context "Roomモデルとの関係" do
      it "N:1となっている" do
        expect(Memo.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
  end
end