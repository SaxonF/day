class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :start_day, :end_day]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @task  = set_user.tasks.build
    if params[:day].nil?
      @today = Date.current
    else
      @today = Date.parse(params[:day])
    end
    @tasks = set_user.tasks.day(@today)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def start_day
    @user.day_started = true
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Day started' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user, status: :unprocessable_entity }
      end
    end
  end

  def end_day
    @user.day_started = false
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Day started' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_name(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
