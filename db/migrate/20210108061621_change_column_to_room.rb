class ChangeColumnToRoom < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column :rooms, :goal, :string, null: false, default: "なし"
    end

    # 変更前の状態
    def down
      change_column :rooms, :goal, :string
    end
  end
end
