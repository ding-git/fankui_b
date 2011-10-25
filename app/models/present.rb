class Present < ActiveRecord::Base
    mount_uploader :fileatt, FileattUploader
    
    
    def acdf
      return 1
    end
    
end
