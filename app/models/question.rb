class Question < ActiveRecord::Base
  belongs_to :test
  has_many :options
  validates_presence_of :question, :answer, :test_id
end
