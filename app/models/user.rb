class User < ActiveRecord::Base
  has_many :competition_users
  has_many :competitions, through: :competition_users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
