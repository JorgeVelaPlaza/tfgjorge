class AddPredictionToCompusers < ActiveRecord::Migration
  def change
    add_column :competition_users, :predicfile, :string
  end
end
