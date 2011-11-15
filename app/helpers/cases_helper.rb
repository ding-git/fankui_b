# coding: UTF-8
module CasesHelper
  
  def expired_nn
    
    if @case.deadline.day <= Time.now.day
      return '已过期'
    end
    
  end

  
end
