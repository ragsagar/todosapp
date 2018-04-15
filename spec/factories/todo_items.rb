FactoryBot.define do
  factory :todo_item do
    name { Faker::GameOfThrones.city }
    done false
    todo_id nil
  end
end
