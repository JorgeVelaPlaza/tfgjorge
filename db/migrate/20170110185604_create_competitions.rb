class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :titulo
      t.text :descripcion
      t.string :categoria
      t.integer :premio
      t.string :dificultad
    end
  end
end
