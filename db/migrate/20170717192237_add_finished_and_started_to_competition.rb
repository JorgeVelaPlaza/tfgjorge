class AddFinishedAndStartedToCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :finished, :boolean
    add_column :competitions, :started, :boolean
  end
end
