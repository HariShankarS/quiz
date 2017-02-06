class Attempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :evaluation
  has_many :user_answers, dependent: :destroy
  validates_uniqueness_of :user_id, scope: [:evaluation_id]#, if: Proc.new { |attempt| attempt.unfinished? }

  def unanswered_questions
  	Question.where(evaluation_id: evaluation_id)
      .joins("LEFT OUTER JOIN user_answers on user_answers.attempt_id = #{self.id} AND user_answers.question_id = questions.id")
      .where("user_answers.id IS NULL").includes(:options)
  end

  def score
    if unfinished?
      '-'
    else
      "#{user_answers.where(correct: true).count}"+"/"+"#{user_answers.count}"
    end  	
  end
end
