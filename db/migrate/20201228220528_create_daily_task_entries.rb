class CreateDailyTaskEntries < ActiveRecord::Migration
  def change
    create_table :daily_task_entries do |t|

      t.timestamps null: false
    end
  end
end
