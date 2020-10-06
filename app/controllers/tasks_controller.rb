class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :show]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = current_user.tasks.page(params[:page]).per(3)
  end
  
  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      flash[:success] = 'タスクが登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが登録が失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'タスクが更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'タスクを削除しました。'
    redirect_to @task
  end
  
  
  private
  
   def task_params
     params.require(:task).permit(:content, :status)
   end
   
   def correct_user
     @task = current_user.tasks.find_by(id: params[:id])
        unless @task
        redirect_to root_url
        end 
   end
   
   def set_task
     @task = current_user.tasks.find(params[:id])
   end
end