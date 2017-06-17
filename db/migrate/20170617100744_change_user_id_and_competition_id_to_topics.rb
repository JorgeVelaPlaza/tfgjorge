class ChangeUserIdAndCompetitionIdToTopics < ActiveRecord::Migration
  def change
    change_column :topics, :user_id, 'integer USING CAST(user_id AS integer)'
    change_column :topics, :competition_id, 'integer USING CAST(competition_id AS integer)'
  end
end
