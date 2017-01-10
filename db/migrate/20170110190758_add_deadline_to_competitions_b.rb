class AddDeadlineToCompetitionsB < ActiveRecord::Migration
  def change
    add_column :competitions, :deadline, :datetime
  end
end
