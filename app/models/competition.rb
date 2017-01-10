class Competition < ActiveRecord::Base
  validates :titulo, presence: true, length: { minimum: 3, maximum: 100}
  validates :descripcion, presence: true
  validates :premio, presence: true
  validates :dificultad, inclusion: { in: ["facil", "medio", "experto"] }
  validates :dificultad, presence: true
  validates :deadline, presence: true
end
