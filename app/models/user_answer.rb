class UserAnswer < ActiveRecord::Base
  belongs_to :attempt
  belongs_to :question
  validates_uniqueness_of :question_id, scope: [:attempt_id]
  validate :time_taken_by_user
  
  after_save :add_result, :check_if_attempt_is_finished

  def check_if_attempt_is_finished
    attempt.check_finished
  end

  def add_result
    update_column(:correct, question.correct_answers.where(id: answer_id).count == 1)
  end

  def time_taken
    if start_time.nil? || end_time.nil?
      0
    else
      (end_time-start_time).to_i
    end
  end

  def time_taken_by_user
    if time_taken > question.time
      answer_id = nil
    end
  end
end
