class AttemptsController < ApplicationController
  before_action :authenticate_user!
  def index
    @evaluations = Evaluation.all
    @user_attempted_evaluations = current_user.attempted_evaluations
  end

  def evaluation
    @attempt = Attempt.where(user_id: current_user.id, evaluation_id: params[:evaluation_id]).first || Attempt.create(user_id: current_user.id, evaluation_id: params[:evaluation_id])
    if @attempt.unfinished?
      @evaluation = Evaluation.where(id: params[:evaluation_id]).includes(:questions).first
      @question = @attempt.unanswered_questions.first
      if @question.nil?
        flash[:warning] = "There are no unanswered questions in this evaluation"
        redirect_to attempts_index_path
      end
      @user_answer = @attempt.user_answers.new
    else
      flash[:error] = "This evaluation was finished"
      redirect_to attempts_index_path
    end
  end

  def user_answer
    @attempt = Attempt.where(id: params[:attempt_id], unfinished: true).first
    @user_answer = @attempt.user_answers.new(user_answer_params)
    @user_answer.question_id = params[:question_id]
    @user_answer.save

    if @attempt.reload.unfinished?
      redirect_to evaluation_attempt_path(evaluation_id: @attempt.evaluation_id)
    else
      flash[:success] = "Evaluation completed"
      redirect_to attempts_index_path
    end
  end

  private
  def user_answer_params
    params.require(:user_answer).permit(:question_id, :answer_id)
  end
end
