class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :group_users 
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :user
  has_many :book_comments, dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :user_rooms
  has_many :chats
  has_many :romms, through: :user_rooms
  
  has_many :view_counts, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
  validates :name, length: {in:2..20}
  validates :introduction, length: {maximum: 50}
  validates :email, presence: true
  
  def follow(user_id)
  relationships.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
  relationships.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
  followings.include?(user)
  end
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
   def self.looks(search, word)
        if search == "perfect_match"
          @user = User.where("name LIKE?","#{word}")
        elsif search == "forward_match"
          @user = User.where("name LIKE?","#{word}%")
        elsif search == "backward_match"
          @user = User.where("name LIKE?","%#{word}")
        elsif search == "partial_match"
          @user = User.where("name LIKE?","%#{word}%")
        else
          @user = User.all
        end
   end
end
