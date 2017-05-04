class RenameTrainingDataFilename < ActiveRecord::Migration
  def change
    rename_column :competitions, :trainingdata_filename, :trainingdata
  end
end
