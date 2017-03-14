class DataTraining < ActiveRecord::Base
  belongs_to :competition
  attr_accessor :file, :name
  mount_uploader :file, FileUploader
end
