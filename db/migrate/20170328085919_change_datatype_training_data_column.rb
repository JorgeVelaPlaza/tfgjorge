class ChangeDatatypeTrainingDataColumn < ActiveRecord::Migration
  def change
    add_column :competitions, :trainingdata_filename, :string
    remove_column :competitions, :training_data
  end
end
