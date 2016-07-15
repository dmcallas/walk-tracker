class BulksController < ApplicationController
  
  def index
    redirect_to users_path
  end
  
  def create
    @user = User.find(params[:user_id])
    @bulk = @user.bulks.create(bulk_params)

    start_date = @bulk.start_date
    minute_values = @bulk.values.split(',').map{|x| x.to_i}
    minute_values.each_with_index { |val,index|
      if val > 0
        entry_date = start_date + index.days
        @user.durations.create(day: entry_date, minutes: val)
      end
    }

    redirect_to user_path(@user)
  end

  private
  def bulk_params    
    params.require(:bulk).permit(:start_date, :values)
  end

  
end
