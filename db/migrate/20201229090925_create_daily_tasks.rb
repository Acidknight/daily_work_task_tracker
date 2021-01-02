class CreateDailyTasks < ActiveRecord::Migration
    def change
      create_table :daily_task_entries do |t|
        t.string :title
        t.string :date 
        t.string :description
        t.string :time
        t.string :notes
        t.string :user_id
        t.string :name
  
        t.timestamps null: false
      end
    end
  end
