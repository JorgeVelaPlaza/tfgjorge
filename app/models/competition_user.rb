class CompetitionUser < ActiveRecord::Base
  belongs_to :competition
  belongs_to :user

  attr_accessor :competition, :user
end
