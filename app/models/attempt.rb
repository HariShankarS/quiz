class Attempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :evaluation
  validates_uniqueness_of :user_id, :scope => [:evaluation_id]
end
