FactoryBot.define do
  factory :todo do
    title { Faker::GameOfThrones.house }
    created_by { Faker::Number.number(10) }
  end
end
