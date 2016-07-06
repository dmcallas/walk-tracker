class DurationsController < ApplicationController

  def index
    @durations = Duration.all
  end

  def show
    @duration = Duration.find(params[:id])
  end

  def edit
    @duration = Duration.find(params[:id])
  end

  def update
    @duration = Duration.find(params[:id])
 
    if @duration.update(duration_params)
      redirect_to @duration
    else
      render 'edit'
    end
  end
  
  def new
    @duration = Duration.new    
  end

  def create
    @user = User.find(params[:user_id])
    @duration = @user.durations.create(duration_params)

    redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(params[:user_id])
    @duration = @user.durations.find(params[:id])
    @duration.destroy
    redirect_to user_path(@user)
  end
  
  private
  def duration_params    
    params.require(:duration).permit(:day, :minutes)
  end

end
