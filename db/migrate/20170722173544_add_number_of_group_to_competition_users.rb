class AddNumberOfGroupToCompetitionUsers < ActiveRecord::Migration
  def change
    add_column :competition_users, :group, :integer
  end
end
