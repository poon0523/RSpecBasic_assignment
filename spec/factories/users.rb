FactoryBot.define do
  # 一般ユーザーのテストデータ
  factory :user do
    name { "test_user" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "testuser" }
    password_confirmation { "testuser" }
    admin {false}

    # 管理者のテストユーザー
    trait :admin do
      name {"test_admin"}
      sequence(:email) { |n| "admin_tester#{n}@example.com" }
      password { "admintestuser" }
      password_confirmation { "admintestuser" }
      admin {true}
    end
  end
end
