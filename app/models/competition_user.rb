class CompetitionUser < ActiveRecord::Base
  belongs_to :competition
  belongs_to :user

  attr_accessor :competition, :user

  mount_uploader :predicfile, PredictionUploader

end
