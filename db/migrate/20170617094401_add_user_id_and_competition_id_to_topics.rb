class AddUserIdAndCompetitionIdToTopics < ActiveRecord::Migration
  def change
     add_column :topics, :user_id, :string
     add_column :topics, :competition_id, :string

  end
end
