class RenameNwinnersColumn < ActiveRecord::Migration
  def change
    rename_column :competitions, :nWinnners, :nWinners
  end
end
