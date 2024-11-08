FactoryBot.define do
    factory :project do
      name { "Test Project" }
      description { "Project description" }
      user
    end
end
  