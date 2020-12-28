anthony = User.create(name: "Anthony", email: "Anthony@Anthony.com", password: "password")

DailyTaskEntry.create(title: "blank", date: "N/A", description: "Blank", time: "2 minutes", notes: "blank", user_id: anthony.id)

anthony.daily_task_entries.create(description: "Doing stuff")