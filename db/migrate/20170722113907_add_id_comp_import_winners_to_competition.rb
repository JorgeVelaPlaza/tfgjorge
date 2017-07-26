class AddIdCompImportWinnersToCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :addIdCompImportWinners, :integer
  end
end
