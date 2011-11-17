class Message < ActiveRecord::Base
  
  def formuser(id)
    return User.find_by_id("#{id}")
  end
  
end
