require 'rails_helper'

RSpec.describe Todo, type: :model do
  # Ensure Todo model has a 1:m relationship 
  it { should have_many(:todo_items).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
