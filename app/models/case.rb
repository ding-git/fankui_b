# coding: utf-8

class Case < ActiveRecord::Base
  
  belongs_to :user

  belongs_to :forumdisplay
  
  has_many :solution
  
  has_many :review
  
  #优先级  
  def level_string
    case self.level
          when 1
            return 'VIP'
          when 2
            return '高'
          when 3
            return '中'
          when 4
            return '低'
          else
            return nil
          end
  end
  
  #是否过期  
  def expired?
    if self.deadline.day < Time.now.day
      return true
    else
      return false
    end
  end
  
end
