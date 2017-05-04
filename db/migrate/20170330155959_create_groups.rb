class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :users_group, array: true, default: []
      t.integer :comp_id
      t.timestamps
    end
  end
end
