class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :close, :open, :task, :update_time_spent]


  # POST /tasks
  # POST /tasks.json
  def create
    @task = User.find_by_name(params[:user_id]).tasks.build(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task.user, notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { 
          @user = User.find_by_name(params[:user_id])
          @tasks = @user.tasks
          render 'users/show' 
        }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to @task.user }
      format.json { head :no_content }
    end
  end

  def close
    
    Task.transaction do
      @task.closed_at = Time.zone.now
      @task.closed = true
      @task.save!
    end

    respond_to do |format|
      format.html { redirect_to @task.user, notice: 'Task was successfully finished.' }
      format.json { head :no_content }
    end

    rescue ActiveRecord::RecordInvalid
      respond_to do |format|
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
  end

  def open
    @task.closed_at = nil
    @task.closed = false
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task.user, notice: 'Task was successfully opened.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_time_spent total = params[:total]
    @task.time_spent = total
    @task.started = true unless @task.started? 
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task.user, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'show' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = set_user.tasks.find(params[:id])
    end

    def set_user
      @user = User.find_by_name(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :status, :closed, :closed_at)
    end
end
