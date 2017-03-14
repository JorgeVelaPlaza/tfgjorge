class CreateDataTrainings < ActiveRecord::Migration
  def change
    create_table :data_trainings do |t|
      t.string :file

      t.timestamps null: false
    end
  end
end
