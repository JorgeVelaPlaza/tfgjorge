class Competition < ActiveRecord::Base
  attr_accessor :name
  has_many :competition_users
  has_many :users, through: :competition_users
  has_many :topics

  validates :titulo, presence: true, length: { minimum: 3, maximum: 100}
  validates :descripcion, presence: true
  validates :premio, presence: true
  validates :dificultad, inclusion: { in: ["Easy", "Medium", "Expert"] }
  validates :dificultad, presence: true
  validates :deadline, presence: true
  validates :metric, inclusion: {in: ["Mean Absolute Error","Root Mean Squared Error",
    "Weighted Mean Absolute Error","Accuracy","Mean Utility"] }
  validates :trainingdata, presence: true
  validates :testdata, presence: true
  validates :type_competition, inclusion: {in: ["regression","classification"] }

  mount_uploader :trainingdata, TrainingdataUploader
  mount_uploader :testdata, TestdataUploader


  def finish_competition
    self.finished = true
    self.save
    CompetitionMailer.endCompetition(self).deliver
  end

  def start_competition
    self.started = true
    self.save
    CompetitionMailer.startCompetition(self).deliver
  end

end
