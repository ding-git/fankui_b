class SessionController < ApplicationController
  
  def follow
    follow_user = User.find(params[:follow_id])
    if User.find(current_user).follow!(follow_user)
      redirect_to :back
    else
      redirect_to 'http://www.baidu.com'
    end
  end
  
  def keep
    present = User.find(params[:present_id])
    if User.find(current_user).keep!(present)
      redirect_to :back
    else
      redirect_to 'http://www.baidu.com'
    end    
  end
  
  
end
