class AddTestDataToCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :testdata, :string
  end
end
