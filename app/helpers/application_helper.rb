# coding: UTF-8

module ApplicationHelper
  
  
  def present_slug(e)
    d = e.created_at
    present_path :year => d.year, :month => d.strftime("%m"), :day => d.strftime("%d"), :id => e.id
  end
  
  
  def chinese_date(date)
    datetime = date.created_at
    time_diff = Time.now.day - datetime.day
    # if time_diff <= 7
    #   return datetime.strftime("#{time_diff}天前 %H:%M:%S")
    # end
    
    case time_diff
          when 0
            datetime.strftime("今天 %H:%M:%S")
          when 1
            datetime.strftime("昨天 %H:%M:%S")
          when 2..7
            datetime.strftime("#{time_diff}天前 %H:%M:%S")
          else
            datetime.strftime("%Y年%m月%d日 %H:%M:%S")
          end
    
  end
  
  def none_signed?
    unless user_signed_in? || cookies[:notice] == 'flase'
      render 'shared/none_signed'
    end
  end
  
end
