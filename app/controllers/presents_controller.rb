class PresentsController < InheritedResources::Base
  
  def index
    
       @presents = Present.all

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
  end
  
end
