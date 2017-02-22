class AttemptsController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def index
    @evaluations = Evaluation.all
    @user_attempted_evaluations = current_user.attempted_evaluations
  end

  def home    
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

  def result
    @attempt = Attempt.includes(:user_answers, evaluation: :questions).find_by_id(params[:attempt_id])
    @evaluation = @attempt.evaluation
    @user_answers = @attempt.user_answers
    @list = @user_answers.joins("INNER JOIN options as attempted_option on attempted_option.id = user_answers.answer_id").select("user_answers.*, attempted_option.value as at_value")
  end

  def user_answer_update
    @user_answer = UserAnswer.find(params[:id])
    @user_answer.update(user_answer_params)
    @attempt = Attempt.find(@user_answer.attempt_id)
    @user_answer.check_if_attempt_is_finished
    if @attempt.reload.unfinished?
      redirect_to evaluation_attempt_path(evaluation_id: @attempt.evaluation_id)
    else
      flash[:success] = "Evaluation completed"
      redirect_to attempt_result_path(attempt_id: @attempt.id)
    end
  end

  def user_answer_add_end_time
    @user_answer = UserAnswer.find(user_answer_time_params[:id])
    @user_answer.end_time = Time.at(user_answer_time_params[:end_time].to_i)
    @user_answer.save
    render json: {user_answer_id: @user_answer.end_time}.to_json
  end
  def user_answer_initialize
    @attempt = Attempt.where(id: user_answer_time_params[:attempt_id], unfinished: true).first
    @user_answer = @attempt.user_answers.new(user_answer_time_params)
    @user_answer.start_time = Time.at(user_answer_time_params[:start_time].to_i)
    @user_answer.save
    render json: {user_answer_id: @user_answer.id}.to_json
  end
  private
  def user_answer_params
    params.permit(:answer_id, :result)
  end

  def user_answer_time_params
    params.require(:user_answer).permit(:id, :question_id, :attempt_id, :start_time, :end_time)
  end
end
