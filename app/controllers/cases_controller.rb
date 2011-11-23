class CasesController < InheritedResources::Base
  
  def index
       @presents = Case.all

    @time = []
    now   = Time.now.to_date
    
    @case = []
    
    @c_c = 9
    
    for i in 0..@c_c
      @time[i] = now + i.day - @c_c.day
      @case[i] = Present.find(:all, :conditions => "request_time = '#{@time[i]}'").count
    end

    if params[:resolve]
    @presents = Present.find(:all, :conditions => "resolve = #{params[:resolve]}")
    end
    
    @forum = Forumdisplay.all
    
  end

  def good
    solution = Solution.find(params[:solution_id])
    if solution.update_attributes!(:good_number => solution.good_number + 1)
      redirect_to :back, notice: 'Thanks you job.'
    end
  end
  
end
