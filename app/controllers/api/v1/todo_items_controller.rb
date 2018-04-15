module Api::V1
  class TodoItemsController < ApplicationController
    before_action :set_todo
    before_action :set_todo_item, only: [:show, :update, :destroy]

    def index
      json_response(@todo.todo_items.order("created_at desc"))
    end

    def show
      json_response(@todo_item)
    end

    def create
      @todo.todo_items.create!(todo_item_params)
      json_response(@todo, :created)
    end

    def update
      @todo_item.update(todo_item_params)
      head :no_content
    end

    def destroy
      @todo_item.destroy
      head :no_content
    end

    private

    def todo_item_params
      params.permit(:name, :done)
    end

    def set_todo
      @todo = Todo.find(params[:todo_id])
    end

    def set_todo_item
      @todo_item = @todo.todo_items.find_by!(id: params[:id]) if @todo
    end
  end
end
