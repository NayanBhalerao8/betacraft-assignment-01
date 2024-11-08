FactoryBot.define do
    factory :comment do
      content { 'Sample Comment' }
      association :task
      association :user
    end
end