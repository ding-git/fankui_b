# coding: utf-8
class Present < ActiveRecord::Base
  
    has_many :review
    
    mount_uploader :fileatt, FileattUploader
    
    
    def level_s
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


    def cause_s
      case self.cause
            when '1'
              return '用户设置问题'
            when '2'
              return '其他'
            else
              return self.cause
            end
    end

    def type
      case self.question_type
            when 1
              return 'Internet Explorer'
            else
              return nil
            end
    end
    
end
