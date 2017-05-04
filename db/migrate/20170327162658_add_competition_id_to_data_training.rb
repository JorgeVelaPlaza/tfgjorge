class AddCompetitionIdToDataTraining < ActiveRecord::Migration
  def change
    add_column :data_trainings, :competition_id, :integer
  end
end
