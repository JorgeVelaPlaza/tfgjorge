class AddMetricsToCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :metric, :string
  end
end
