class CreateCompetitionUsers < ActiveRecord::Migration
  def change
    create_table :competition_users do |t|
      t.integer :competition_id
      t.integer :user_id
    end
  end
end
