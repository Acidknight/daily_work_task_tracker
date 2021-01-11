class DeleteDailyTasks < ActiveRecord::Migration
  def change
    drop_table :daily_tasks

  end
end
