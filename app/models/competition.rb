class Competition < ActiveRecord::Base
  attr_accessor :name, :data_trainings_attributes
  has_many :data_trainings
  has_many :competition_users
  has_many :users, through: :competition_users

  accepts_nested_attributes_for :data_trainings, allow_destroy: true

  validates :titulo, presence: true, length: { minimum: 3, maximum: 100}
  validates :descripcion, presence: true
  validates :premio, presence: true
  validates :dificultad, inclusion: { in: ["Fácil", "Medio", "Experto"] }
  validates :dificultad, presence: true
  validates :deadline, presence: true
end
