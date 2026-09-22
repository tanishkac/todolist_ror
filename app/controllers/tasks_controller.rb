class TasksController < ApplicationController
  def index
    @tasks = Task.order(created_at: :asc)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "Task created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to tasks_path, notice: "Task deleted!"
  end

  def toggle
    @task = Task.find(params[:id])
    @task.update(completed: !@task.completed)
    redirect_to tasks_path, notice: "Task updated!", status: :see_other
  end

  private

  def task_params
    params.require(:task).permit(:title)
  end 
end

