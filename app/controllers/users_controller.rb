class UsersController < ApplicationController

  def index
    @users = User.all
    durations = Duration.all
    @grid = PivotTable::Grid.new do |g|
      g.source_data  = durations
      g.column_name  = :day
      g.row_name     = :user_id
      g.value_name   = :minutes
    end

    respond_to do |format|
      format.html
      format.csv {
        # Build and return CSV file using the pivot table
        out_data = CSV.generate do |csv|
          csv << @grid.build.column_headers.unshift('')
          @grid.build.rows.each do |row|
            user = User.find(row.header)
            user_name = user.username
            row_data = row.data.map{|n| n.nil? ? '' : n.minutes}
            row_data[0] = user_name
            csv << row_data
          end
        end

        send_data(out_data, :filename => 'walk_times.csv')
      }
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
