class RemoveIsFinishedFromTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :is_finished, :boolean
  end
end
