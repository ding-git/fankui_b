class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :case
  has_many :review
  has_many :solution
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :invitable

  # Setup accessible (or protected) attributes for your model
  
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false
  
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :people
  
  mount_uploader :people, PeopleUploader
  
    # 
  scope :admin, where(:id => 5)
  
  scope :last_week_sign_in , where("created_at <= ? AND created_at > ?", Time.now , Time.now - 15.days)

  def avatar
    if !self.people.blank?
      return self.people
    else
      return '/images/none_logo.jpg'
    end      
  end







  def follow!(user)
    $redis.multi do
      $redis.sadd(self.redis_key(:following), user.id)
      $redis.sadd(user.redis_key(:followers), self.id)
    end
  end
  
  # unfollow a user
  def unfollow!(user)
    $redis.multi do
      $redis.srem(self.redis_key(:following), user.id)
      $redis.srem(user.redis_key(:followers), self.id)
    end
  end
  
  # users that self follows
  def followers
    user_ids = $redis.smembers(self.redis_key(:followers))
    User.where(:id => user_ids)
  end

  # users that follow self
  def following
    user_ids = $redis.smembers(self.redis_key(:following))
    User.where(:id => user_ids)
  end

  # users who follow and are being followed by self
  def friends
    user_ids = $redis.sinter(self.redis_key(:following), self.redis_key(:followers))
    User.where(:id => user_ids)
  end

  # does the user follow self
  def followed_by?(user)
    $redis.sismember(self.redis_key(:followers), user.id)
  end
  
  # does self follow user
  def following?(user)
    $redis.sismember(self.redis_key(:following), user.id)
  end

  # number of followers
  def followers_count
    $redis.scard(self.redis_key(:followers))
  end

  # number of users being followed
  def following_count
    $redis.scard(self.redis_key(:following))
  end
  
  # helper method to generate redis keys
  def redis_key(str)
    "user:#{self.id}:#{str}"
  end

  #收藏主题
    
  def keep!(user)
    $redis.multi do
      $redis.sadd(self.redis_key(:keeping), user.id)
      $redis.sadd(user.redis_key(:keeps), self.id)
    end
  end
  

  def keeping
    user_ids = $redis.smembers(self.redis_key(:keeping))
    Present.where(:id => user_ids)
  end
  
  # users that self follows
  def keeps
    user_ids = $redis.smembers(self.redis_key(:keeps))
    User.where(:id => user_ids)
  end
  
  
end
