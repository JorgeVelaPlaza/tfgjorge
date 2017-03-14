class AddSummaryToCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :summary, :string
  end
end
