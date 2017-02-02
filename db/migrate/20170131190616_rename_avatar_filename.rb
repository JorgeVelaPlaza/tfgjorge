class RenameAvatarFilename < ActiveRecord::Migration
  def change
    rename_column :users, :avatar_filename, :avatar
  end
end
