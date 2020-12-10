class TasksController < ApplicationController
  before_action :set_paper_trail_whodunnit
  before_action :get_project
  before_action :set_task, only: [:show, :edit, :update, :destroy, :versions]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = case params['filter']
              when 'all'
                @project.tasks.all
              when 'completed'
                @project.tasks.where(completed: true)
              when 'not_completed'
                @project.tasks.where(completed: false)
              else
                @project.tasks.where(completed: false)
              end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    # @task = @Project.task.new
    @task = @project.tasks.build
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    # @task = Task.new(task_params)
    @task = @project.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_tasks_path(@project), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_tasks_path(@project), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def versions
    task = @project.tasks.where("project_id = ? AND id = ?", params[:project_id], params[:task_id]).first
    @versions = task.versions.drop(1)
  end

  private
    def get_project
      @project = Project.find(params[:project_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = @project.tasks.where("project_id = ? AND id = ?", params[:project_id], params[:id])
      [@project, @task = @task.first]
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :completed, :project_id)
    end
end
