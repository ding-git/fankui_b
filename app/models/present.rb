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
    
    #计数器
    
    def count!
      uids = Rails.cache.read("Present:user_count:#{self.id}")
      
      if uids.blank?
        uids = 1
      else
        uids += 1
      end
      
      Rails.cache.write("Present:user_count:#{self.id}",uids)
    end
    
    def count
      uids = Rails.cache.read("Present:user_count:#{self.id}")
      return uids      
    end
    
    # 检查用户是否看过
    # result:
    #   0 读过
    #   1 未读
    #   2 最后是用户的回复
    def user_readed?(user_id)
      uids = Rails.cache.read("Present:user_read:#{self.id}")
      if uids.blank?
        if self.last_reply_user_id == user_id || self.user_id == user_id
          return 2
        else 
          return 1
        end
      end

      if uids.index(user_id)
        return 0
      else
        if self.last_reply_user_id == user_id || self.user_id == user_id
          return 2
        else 
          return 1
        end
      end
    end    
    
    
    # 记录用户读过
    def user_readed(user_id)
      uids = Rails.cache.read("Present:user_read:#{self.id}")
      if uids.blank?
        uids = [user_id]
      else
        uids = uids.dup
      end

  		uids << user_id
      Rails.cache.write("Present:user_read:#{self.id}",uids)
    end
    
    # helper method to generate redis keys
    def redis_key(str)
      "Present:#{self.id}:#{str}"
    end
end
