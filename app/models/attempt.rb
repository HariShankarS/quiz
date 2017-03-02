class Attempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :evaluation
  has_many :user_answers, dependent: :destroy
  validates_uniqueness_of :user_id, scope: [:evaluation_id]#, if: Proc.new { |attempt| attempt.unfinished? }

  def unanswered_questions
  	Question.where(evaluation_id: evaluation_id)
      .joins("LEFT OUTER JOIN user_answers on user_answers.attempt_id = #{self.id} AND user_answers.question_id = questions.id")
      .where("(user_answers.start_time IS NOT NULL and ( user_answers.start_time + (questions.time || ' second')::interval ) >= now() and user_answers.end_time IS NULL) or (user_answers.id IS NULL)").includes(:options)
  end

  def score
    if unfinished?
      '-'
    else
      "#{user_answers.where(correct: true).count}"+"/"+"#{user_answers.count}"
    end  	
  end

  def correct_answers_count
    if unfinished?
      '-'
    else
      "#{user_answers.where(correct: true).count}"
    end
  end

  def check_finished
    unless unanswered_questions.present?
      update_attribute(:unfinished, false)
    end
  end
end
