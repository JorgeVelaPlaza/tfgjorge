class RenameIdCompImportWinners < ActiveRecord::Migration
  def change
    rename_column :competitions, :addIdCompImportWinners, :idCompImportWinners
  end
end
