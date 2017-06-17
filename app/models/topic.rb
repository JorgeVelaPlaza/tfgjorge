class Topic < ActiveRecord::Base
  belongs_to :competition
  belongs_to :user
  has_many :comments
end
