# spec/factories/tasks.rb
FactoryBot.define do
    factory :task do
      title { "Test Task" }
      description { "Task description" }
      project
      user
    end
end
  