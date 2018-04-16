require 'rails_helper'

RSpec.describe 'Todo Items API' do
  # Initialize the test data
  let!(:todo) { create(:todo) }
  let!(:todo_items) { create_list(:todo_item, 20, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:id) { todo_items.first.id }
  let(:basic_auth) { { 'Authorization' => "Basic #{Base64::encode64('todoapp:aymcommerce')}" } }

  describe 'GET /api/v1/todos/:todo_id/items/' do
    before { get "/api/v1/todos/#{todo_id}/items", headers: basic_auth}

    context "when todo exists" do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'return all todo items' do
        expect(json.size).to eq(20)
      end
    end

    context "when todo doesn't exist" do
      let(:todo_id) { 0 }

      it 'return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'return not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  describe 'GET /api/v1/todos/:todo_id/items/:id' do
    before { get "/api/v1/todos/#{todo_id}/items/#{id}", headers: basic_auth}

    context 'when todo item exists' do
      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'return the todo item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when todo item does not exist' do
      let(:id) { 0 }

      it 'return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'return not found message' do
        expect(response.body).to match(/Couldn't find TodoItem/)
      end
    end
  end

  describe 'POST /api/v1/todos/:todos_id/items/' do
    let(:input_data) { { name: 'Cook dinner', done: false } }
    context 'when valid input data is given' do
      before { post "/api/v1/todos/#{todo_id}/items", params: input_data, headers: basic_auth}

      it 'return status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'check db record' do
        item = TodoItem.find_by(id: json['id'])
        expect(item.name).to eq('Cook dinner')
      end
    end

    context 'when request is invalid' do
      let (:invalid_input) { { done: false } }
      before { post "/api/v1/todos/#{todo_id}/items", params: invalid_input, headers: basic_auth}

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'return validation error' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /api/v1/todos/:todos_id/items/:id' do
    let(:input_data) { { name: 'Washing clothes', done: true } }

    before { put "/api/v1/todos/#{todo_id}/items/#{id}", params: input_data, headers: basic_auth }

    context 'when todo item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'update todo item' do
        todo_item = TodoItem.find(id)
        expect(todo_item.name).to match(/Washing clothes/)
        expect(todo_item.done).to eq(true)
      end
    end

    context "When todo item doesn't exist" do
      let(:id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find TodoItem/)
      end
    end
  end


  describe 'DELETE /api/v1/todos/:todos_id/items/:id' do

    context 'when todo item exists' do
      before { delete "/api/v1/todos/#{todo_id}/items/#{id}", headers: basic_auth }

      it 'delete db record' do
        todo_item = TodoItem.find_by(id: id)
        expect(todo_item).to eq(nil)
      end

      it 'return status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'return empty response' do
        expect(response.body).to be_empty
      end
    end

    context "when todo item doesn't exist" do
      let(:id) { 1000 }
      before { delete "/api/v1/todos/#{todo_id}/items/#{id}", headers: basic_auth }

      it 'return status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
