class AddCreatedatAndUpdatedatToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :created_at, :datetime
    add_column :competitions, :updated_at, :datetime
  end
end
