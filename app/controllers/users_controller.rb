class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @following = User.find(params[:id]).following
    @friends = User.find(params[:id]).friends
    @keeping = User.find(params[:id]).keeping
  end

  def index
    @users = User
  end
  
  def followers
    @user = User.find(params[:id])
    @following = User.find(params[:id]).following
  end
  
  def favorites
    @user = User.find(params[:id])
    @keeping = User.find(params[:id]).keeping    
  end
  
  def messages
    @messages = Message.where('msgfrom_id = ? OR msg_to_id = ?',params[:id],params[:id]).order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    
    @message = Message.new
  end
  
  def update
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.update_attributes!(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
