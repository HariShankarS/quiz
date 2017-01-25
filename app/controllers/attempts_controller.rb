class AttemptsController < ApplicationController
  before_action :authenticate_user!
  def index
  	@evaluations = Evaluation.all
  end

  def evaluation
  	@evaluation = Evaluation.find_by_id(params[:evaluation_id])
  end
end
