class Question < ActiveRecord::Base
  belongs_to :evaluation
  has_many :options, dependent: :destroy 
  has_many :user_answers # for multiple users
  
  validates_presence_of :question, :evaluation_id
  before_validation :copy_time_from_evaluation

  def self.disable_time(t)
    t.present? && Evaluation.find_by_id(t).try(:time_independent?)   
  end

  def self.set_time(t)
  	unless Evaluation.find_by_id(t).try(:question_time_setting?)
      Evaluation.find_by_id(t).try(:time_per_question)
    else
    end
  end

  private
  def copy_time_from_evaluation
    if evaluation.present?
      unless evaluation.time_independent? && evaluation.question_time_setting?
        time = evaluation.time_per_question
      end
    end
  end
end
