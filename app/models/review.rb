class Review < ActiveRecord::Base
  belongs_to :present
  belongs_to :user
  belongs_to :case
end
