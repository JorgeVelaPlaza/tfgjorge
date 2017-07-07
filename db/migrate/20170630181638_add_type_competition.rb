class AddTypeCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :type_competition, :string
  end
end
