class AddScoreToCompetitionUser < ActiveRecord::Migration
  def change
    add_column :competition_users, :score, :float
  end
end
