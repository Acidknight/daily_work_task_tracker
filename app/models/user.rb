class User < ActiveRecord::Base
   has_secure_password

   validates :email, uniqueness: true

   has_many :daily_task_entries
end
