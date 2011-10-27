# coding: utf-8
class Present < ActiveRecord::Base
  
    has_many :review
    
    mount_uploader :fileatt, FileattUploader
    
    
    def level_s
      case self.level
            when 1
              return '高'
            else
              return nil
            end
    end


    def cause_s
      case self.cause
            when '1'
              return 'wwwf'
            when '2'
              return 'zzzc'
            else
              return self.cause
            end
    end

    def type
      case self.question_type
            when 1
              return '系统问题'
            else
              return nil
            end
    end
    
end
