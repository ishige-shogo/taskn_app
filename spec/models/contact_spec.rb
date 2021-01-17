# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact, "Contactモデルに関するテスト", type: :model do

  describe "実際に保存する" do
    it "有効なお問い合わせ新規作成の場合は保存されるか" do
      expect(FactoryBot.build(:contact)).to be_valid
    end
    it "お問い合わせ作成時に未読状態で保存されるか" do
      expect(FactoryBot.build(:contact)).status.to eq false
    end
  end

  describe "空白のバリデーションテスト" do
    subject { contact.valid? }

    let(:user) { create(:user) }
    let!(:contact) { build(:contact, user_id: user.id) }

    context "titleカラム" do
      it "空欄でないこと" do
        contact.title = ""
        is_expected.to eq false
      end
      it "30文字以内であること：30文字はo" do
        contact.title = Faker::Lorem.characters(number: 30)
        is_expected.to eq true
      end
      it "30文字以内であること：31文字はx" do
        contact.title = Faker::Lorem.characters(number: 31)
        is_expected.to eq false
      end
    end

    context "bodyカラム" do
      it "空欄でないこと" do
        contact.body = ""
        is_expected.to eq false
      end
      it "10文字以上であること：9文字はx" do
        contact.body = Faker::Lorem.characters(number: 9)
        is_expected.to eq false
      end
      it "10文字以上であること：10文字はo" do
        contact.body = Faker::Lorem.characters(number: 10)
        is_expected.to eq true
      end
      it "400文字以内であること：400文字はo" do
        contact.body = Faker::Lorem.characters(number: 400)
        is_expected.to eq true
      end
      it "400文字以上であること：401文字はx" do
        contact.body = Faker::Lorem.characters(number: 401)
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1となっている" do
        expect(Contact.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end