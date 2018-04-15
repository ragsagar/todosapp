require 'rails_helper'

RSpec.describe TodoItem, type: :model do
  # Make sure one todo item belong to single record.
  it { should belong_to(:todo) }
  # Making sure name is there
  it { should validate_presence_of(:name) }
end
