class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
				 :omniauthable, :omniauth_providers => [:facebook]

  has_many :authored_questions, class_name: 'Question', foreign_key: 'author_id'
  has_many :approved_questions, class_name: 'Question', foreign_key: 'moderator_id'
  has_many :answers

  enum role: [ :admin, :moderator, :author, :member]

  has_and_belongs_to_many :followers, class_name: 'User', :join_table => "followees_followers", foreign_key: "followee_id", association_foreign_key: "follower_id"
  has_and_belongs_to_many :followees, class_name: 'User', :join_table => "followees_followers", foreign_key: "follower_id", association_foreign_key: "followee_id"

  def generate_access_token
    # access token generate
    loop do
      self.access_token = SecureRandom.hex
      if (User.find_by_access_token(self.access_token).nil?)
        break
      end
    end
    self.access_token_expiry = Time.now + 3.months
    self.save
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.role = :member
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      #user.name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
    end
  end

  def role? (str)
    if (self.role.nil?)
      return false
    end
    
    if (User.roles[self.role] <= User.roles[str])
      return true
    else
      return false
    end
  end

end
