class User < ActiveRecord::Base
   has_secure_password

   has_many :daily_task_entries
end
