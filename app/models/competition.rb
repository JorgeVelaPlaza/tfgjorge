class Competition < ActiveRecord::Base
  attr_accessor :name
  has_many :competition_users
  has_many :users, through: :competition_users

  validates :titulo, presence: true, length: { minimum: 3, maximum: 100}
  validates :descripcion, presence: true
  validates :premio, presence: true
  validates :dificultad, inclusion: { in: ["Fácil", "Medio", "Experto"] }
  validates :dificultad, presence: true
  validates :deadline, presence: true

  mount_uploader :trainingdata, TrainingdataUploader
  mount_uploader :testdata, TestdataUploader

  def inscriptionToSubmit(id_comp, id_user)
    c = CompetitionUser.where(:competition_id => id_comp).where(:user_id => id_user)
    return c
  end
end
