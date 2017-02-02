class User < ActiveRecord::Base
  has_many :competition_users
  has_many :competitions, through: :competition_users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: { minimum: 3, maximum: 100}
  validates :username, presence: true
  validates :pais, presence: true, length: { minimum: 3, maximum: 100}
  validates :ciudad, presence: true, length: { minimum: 3, maximum: 100}
  validates :email, presence: true


  mount_uploader :avatar, AvatarUploader
end