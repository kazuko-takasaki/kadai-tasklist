class TasksController < ApplicationController
  @task = Task.find(params[:id])
  
  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = 'タスクが登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが登録が失敗しました'
    　render :new
    end
  end

  def edit
    #
  end

  def update
    #
    if @task.update(task_params)
      flash[:success] = 'タスクが更新されました'
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
    　render :edit
    end
  end

  def destroy
    #
    @task.destroy
    flash[:success] = 'タスクは削除されました'
    redirect_to tasks_url
  end
  
  private
   def task_params
     params.require(:task).permit(:content)
   end
end
