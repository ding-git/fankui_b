class AjaxController < ActionController::Base
  
  def new
    @case = Case.new
  end
  
  def edit
    @case = Case.find(params[:case_id])
  end
  
  def answer
    @solution = Solution.new
  end
  
  
  def notice
    
    cookies[:notice] = 'flase'
    
    respond_to do |format|
      format.js
    end
  end
  
  
  def sign
    render :template => 'devise/sessions/new'
  end
  
end
  