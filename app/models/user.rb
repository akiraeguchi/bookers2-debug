class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  validates :name, length: { maximum:20, minimum:2 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :rooms, through: :user_rooms
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy

  has_many :relationships
  has_many :followings, through: :relationships, source: :follower
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follower_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follower_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follower_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

end
