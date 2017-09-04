class AddAvatarCompetitionToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :avatar_competition, :string
  end
end
