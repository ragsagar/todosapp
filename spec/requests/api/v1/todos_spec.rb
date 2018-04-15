require 'rails_helper'

RSpec.describe 'Todo List API', type: :request do
  # Initialize data
  let!(:todos) { create_list(:todo, 5) }
  let(:todo_id) { todos.first.id }

  describe 'GET /api/v1/todos' do
    before { get '/api/v1/todos' }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns todos' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

  end

  describe 'GET /api/v1/todos/:id' do
    before { get "/api/v1/todos/#{todo_id}" }

    context 'when the todo list exists' do
      it 'return ok status 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns single todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(todo_id)
      end

    end

    context "when the todo list doesn't exist" do
      let(:todo_id) { 100 }

      it 'returns not found status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /api/v1/todos' do
    let(:input_data) { { title: 'Todays todos', 'created_by': '1' } }

    context 'when valid request to create' do 
      before { post '/api/v1/todos', params: input_data }

      it 'returns created status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'creates a todo' do
        expect(json['title']).to eq('Todays todos')
      end

      it 'created a db record' do
        t = Todo.find_by(id: json['id'])
        expect(t).not_to eq(nil)
      end
    end

    context 'when request is invalid' do
      before { post '/api/v1/todos', params: { title: 'Tomorrow todos' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  describe 'PUT /api/v1/todos/:id' do
    let(:input_data) { { title: 'Tomorrow todos' } }

    context 'when the todo item exists' do
      before { put "/api/v1/todos/#{todo_id}", params: input_data }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'update db record' do
        todo = Todo.find_by(id: todo_id)
        expect(todo.title).to eq('Tomorrow todos')
      end

      it 'updates the record' do
        expect(response.body).to be_empty
      end
    end
  end

  describe 'DELETE /api/v1/todos/:id' do
    before { delete "/api/v1/todos/#{todo_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'delete db record' do
      todo = Todo.find_by(id: todo_id)
      expect(todo).to eq(nil)
    end

  end
end
