class AddCompetitionFields < ActiveRecord::Migration
  def change
    add_column :competitions, :evaluation, :text
    add_column :competitions, :prizes, :text
    add_column :competitions, :about, :text
    add_column :competitions, :engagement, :text
    add_column :competitions, :resources, :text
    add_column :competitions, :timeline, :text
    add_column :competitions, :tutorial, :text
    add_column :competitions, :training_data, :text
    add_column :competitions, :rules, :text
  end
end
