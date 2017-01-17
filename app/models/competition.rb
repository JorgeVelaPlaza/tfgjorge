class Competition < ActiveRecord::Base
  has_many :competition_users
  has_many :users, through: :competition_users
  validates :titulo, presence: true, length: { minimum: 3, maximum: 100}
  validates :descripcion, presence: true
  validates :premio, presence: true
  validates :dificultad, inclusion: { in: ["Fácil", "Medio", "Experto"] }
  validates :dificultad, presence: true
  validates :deadline, presence: true
end
