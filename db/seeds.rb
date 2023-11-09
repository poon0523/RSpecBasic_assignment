# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 50.times do |n|
#     Task.create!(
#       title: "task_title_#{n + 1}",
#       content: "task_content_#{n + 1}",
#     )
#   end



# # 一般ユーザーのタスク
# # タスクデータ1
# Task.create(
#   title: "first_task",
#   content: "content_first_task",
#   deadline_on: Date.new(2025,2,18),
#   priority: 1,
#   status: 0,
#   user_id: 1,
# )

# # タスクデータ2
# Task.create(
#   title: "second_task",
#   content: "content_second_task",
#   deadline_on: Date.new(2025,2,17),
#   priority: 2,
#   status: 1,
#   user_id: 1,
# )

# # タスクデータ3
# Task.create(
#   title: "third_task",
#   content: "content_third_task",
#   deadline_on: Date.new(2025,2,16),
#   priority: 0,
#   status: 2,
#   user_id: 1,
# )

# # タスクデータ4
# Task.create(
#   title: "fourth_task",
#   content: "content_fourth_task",
#   deadline_on: Date.new(2025,2,15),
#   priority: 2,
#   status: 0,
#   user_id: 1,
# )

# # タスクデータ5
# Task.create(
#   title: "fifth_task",
#   content: "content_fifth_task",
#   deadline_on: Date.new(2025,2,10),
#   priority: 1,
#   status: 1,
#   user_id: 1,
# )

# # タスクデータ6
# Task.create(
#   title: "sixth_task",
#   content: "content_sixth_task",
#   deadline_on: Date.new(2025,2,20),
#   priority: 2,
#   status: 2,
#   user_id: 1,
# )

# # タスクデータ7
# Task.create(
#   title: "seventh_task",
#   content: "content_seventh_task",
#   deadline_on: Date.new(2025,2,19),
#   priority: 0,
#   status: 0,
#   user_id: 1,
# )

# # タスクデータ8
# Task.create(
#   title: "eighth_task",
#   content: "content_eighth_task",
#   deadline_on: Date.new(2025,2,2),
#   priority: 1,
#   status: 2,
#   user_id: 1,
# )

# # タスクデータ9
# Task.create(
#   title: "ninth_task",
#   content: "content_ninth_task",
#   deadline_on: Date.new(2025,2,13),
#   priority: 1,
#   status: 2,
#   user_id: 1,
# )


# # タスクデータ10
# Task.create(
#   title: "tenth_task",
#   content: "content_tenth_task",
#   deadline_on: Date.new(2025,2,19),
#   priority: 1,
#   status: 2,
#   user_id: 1,
# )

# # 管理者のタスク
# Task.create(
#   title: "admin_first_task",
#   content: "content_first_task",
#   deadline_on: Date.new(2025,2,18),
#   priority: 1,
#   status: 0,
#   user_id: 2,
# )

# # タスクデータ2
# Task.create(
#   title: "admin_second_task",
#   content: "content_second_task",
#   deadline_on: Date.new(2025,2,17),
#   priority: 2,
#   status: 1,
#   user_id: 2,
# )


# # タスクデータ3
# Task.create(
#   title: "admin_third_task",
#   content: "content_third_task",
#   deadline_on: Date.new(2025,2,16),
#   priority: 0,
#   status: 2,
#   user_id: 2,
# )

# # タスクデータ4
# Task.create(
#   title: "admin_fourth_task",
#   content: "content_fourth_task",
#   deadline_on: Date.new(2025,2,15),
#   priority: 2,
#   status: 0,
#   user_id: 2,
# )

# # タスクデータ5
# Task.create(
#   title: "admin_fifth_task",
#   content: "content_fifth_task",
#   deadline_on: Date.new(2025,2,10),
#   priority: 1,
#   status: 1,
#   user_id: 2,
# )

# # タスクデータ6
# Task.create(
#   title: "admin_sixth_task",
#   content: "content_sixth_task",
#   deadline_on: Date.new(2025,2,20),
#   priority: 2,
#   status: 2,
#   user_id: 2,
# )

# # タスクデータ7
# Task.create(
#   title: "admin_seventh_task",
#   content: "content_seventh_task",
#   deadline_on: Date.new(2025,2,19),
#   priority: 0,
#   status: 0,
#   user_id: 2,
# )

# # タスクデータ8
# Task.create(
#   title: "admin_eighth_task",
#   content: "content_eighth_task",
#   deadline_on: Date.new(2025,2,2),
#   priority: 1,
#   status: 2,
#   user_id: 2,
# )

# # タスクデータ9
# Task.create(
#   title: "admin_ninth_task",
#   content: "content_ninth_task",
#   deadline_on: Date.new(2025,2,13),
#   priority: 1,
#   status: 2,
#   user_id: 2,
# )


# # タスクデータ10
# Task.create(
#   title: "admin_tenth_task",
#   content: "content_tenth_task",
#   deadline_on: Date.new(2025,2,19),
#   priority: 1,
#   status: 2,
#   user_id: 2,
# )




# 一般ユーザー
User.create(
  name: "test_user",
  email: "test_user@gmail.com",
  password: "testuser",
  password_confirmation: "testuser",
  admin: false,
)

# 管理者
User.create(
  name: "test_admin",
  email: "test_admin@gmail.com",
  password: "testadmin",
  password_confirmation: "testadmin",
  admin: true,
)

base_time0 = Time.current.beginning_of_day
priority = [0,1,2]
status = [0,1,2]

# 一般ユーザーのタスク
50.times do |n|
    Task.create!(
      title: "task_title_#{n + 1}",
      content: "task_content_#{n + 1}",
      deadline_on: base_time0.advance(days: n),
      priority: priority.sample,
      status: status.sample,
      user_id: 1
    )
  end

# 管理者のタスク
50.times do |n|
  Task.create!(
    title: "admin_task_title_#{n + 1}",
    content: "admin_task_content_#{n + 1}",
    deadline_on: base_time0.advance(days: n),
    priority: priority.sample,
    status: status.sample,
    user_id: 2
  )
end
