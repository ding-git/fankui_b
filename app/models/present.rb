class Present < ActiveRecord::Base
    mount_uploader :fileatt, FileattUploader
end
