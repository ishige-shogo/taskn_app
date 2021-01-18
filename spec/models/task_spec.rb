# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, "Taskモデルに関するテスト", type: :model do
  describe "実際に保存する" do
    it "有効なTODOリスト新規作成の場合は保存されるか" do
      expect(FactoryBot.build(:task)).to be_valid
    end
  end

  describe "空白のバリデーションテスト" do
    subject { task.valid? }

    let(:user) { create(:user) }
    let(:room) { create(:room) }
    let!(:task) { build(:task, user_id: user.id, room_id: room.id) }

    context "bodyカラム" do
      it "空欄ではないこと" do
        task.body = ""
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1となっている" do
        expect(Task.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context "Roomモデルとの関係" do
      it "N:1となっている" do
        expect(Task.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
  end
end
