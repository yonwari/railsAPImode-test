module Api
  module V1
    class TasksController < ApplicationController
      def index
        tasks = Task.all
        render json: {
          status: 'SUCCESS',
          message: 'loaded tasks',
          data: tasks
        }
      end

      def show
        task = Task.find(params[:id])
        render json: {
          status: 'SUCCESS',
          message: 'loaded tasks',
          data: task
        }
      end

      def create
        task = Task.new(task_params)
        if task.save
          render json: {
            status: 'SUCCESS',
            message: 'created task',
            data: task
          }
        else
          render json: {
            status: 'ERROR',
            message: 'task not saved',
            data: task.errors
          }
        end
      end

      def update
        task = Task.find(params[:id])
        if task.update(task_params)
          render json: {
            status: 'SUCCESS',
            message: 'task updated',
            data: task
          }
        else
          render json: {
            status: 'ERROR',
            message: 'taks not updated',
            data: task.errors
          }
        end
      end

      def destroy
        task = Task.find(params[:id])
        task.destroy
        render json: {
          status: 'SUCCESS',
          message: 'task destroyed',
          data: task
        }
      end

      private
      def task_params
        params.require(:task).permit(:title, :is_done)
      end
    end
  end
end
