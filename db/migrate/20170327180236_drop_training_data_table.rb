class DropTrainingDataTable < ActiveRecord::Migration
  def change
    drop_table :data_trainings
  end
end
