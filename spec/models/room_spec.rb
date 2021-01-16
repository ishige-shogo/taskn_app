# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room, "モデルに関するテスト", type: :model do
  describe "実際に保存する" do
    it "有効なルーム新規作成の場合は保存されるか" do
      expect(FactoryBot.build(:room)).to be_valid
    end
  end
  context "空白のバリデーションチェック" do
    it "ルーム名が空白の場合にエラーメッセージが表示されるか" do
      room = Room.new(name: "", goal: "hoge", roompass: "hoge", user_id: 1)
      expect(room).to be_invalid
      expect(room.errors[:name]).to include("can't be blank")
    end
    it "目標が空白の場合でも新規作成できるか" do
      room = Room.new(name: "hoge", goal: "", roompass: "hoge", user_id: 1)
      expect(room).to be_valid
    end
    it "ルームパスワードが空白の場合にエラーメッセージが表示されるか" do
      room = Room.new(name: "hoge", goal: "hoge", roompass: "", user_id: 1)
      expect(room).to be_invalid
      expect(room.errors[:roompass]).to include("can't be blank")
    end
  end
end