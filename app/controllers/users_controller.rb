class UsersController < ApplicationController

  def index
    durations = Duration.all
    @grid = PivotTable::Grid.new do |g|
      g.source_data  = durations
      g.column_name  = :day
      g.row_name     = :user_id
      g.value_name   = :minutes
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
 
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def new
    @user = User.new    
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
 
    redirect_to users_path
  end
  
  private
  def user_params    
    params.require(:user).permit(:username, :first, :last)
  end

end
