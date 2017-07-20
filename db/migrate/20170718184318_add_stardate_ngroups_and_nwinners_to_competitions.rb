class AddStardateNgroupsAndNwinnersToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :startdate, :datetime
    add_column :competitions, :nGroups, :integer
    add_column :competitions, :nWinnners, :integer
  end
end
