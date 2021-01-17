# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, "Userモデルに関するテスト", type: :model do
  describe "実際に保存する" do
    it "有効な利用者登録の場合は保存されるか" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end
  describe "空白のバリデーションテスト" do
    subject { user.valid? }

    let(:user){ build(:user) }

    context "nameカラム" do
      it "空欄でないこと" do
        user.name = ""
        is_expected.to eq false
      end
    end
  end
  describe "アソシエーションのテスト" do
    context "Roomモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:rooms).macro).to eq :has_many
      end
    end
    context "Contactモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:contacts).macro).to eq :has_many
      end
    end
    context "Taskモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:tasks).macro).to eq :has_many
      end
    end
    context "Memoモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:memos).macro).to eq :has_many
      end
    end
  end
end