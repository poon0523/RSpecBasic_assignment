# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # 「task」のように存在するクラス名のスネークケースをテストデータ名とする場合、そのクラスのテストデータが作成されます
  factory :task do
    title { '書類作成' }
    content { '企画書を作成する。' }
    deadline_on { '	2025-02-20' }
    status {0}
    priority {0}
    user
  end
end