class UserAnswer < ActiveRecord::Base
  belongs_to :attempt
  belongs_to :question
  validates_uniqueness_of :question_id, scope: [:attempt_id]

  after_save :check_if_attempt_is_finished
  after_save :result

  def check_if_attempt_is_finished
  	unless attempt.unanswered_questions.present?
      attempt.update_attribute(:unfinished, false)
  	end
  end

  def result
    question.correct_answers.where(id: answer_id).count == 1
  end
end
