class Question < ActiveRecord::Base
  belongs_to :test
  has_many :options, dependent: :destroy 
  validates_presence_of :question, :test_id
  before_validation :copy_time_from_test

  def self.disable_time(t)
    t.present? && Test.find_by_id(t).try(:time_independent?)   
  end

  def self.set_time(t)
  	unless Test.find_by_id(t).try(:question_time_setting?)
      Test.find_by_id(t).try(:time_per_question)
    else
    end
  end

  private
  def copy_time_from_test
    unless test.time_independent? && test.question_time_setting?
      time = test.time_per_question
    end
  end
end
