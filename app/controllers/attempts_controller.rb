class AttemptsController < ApplicationController
  def index
  	@evaluations = Evaluation.all
  end

  def evaluation
  	@evaluation = Evaluation.find(params[:evaluation_id])
  end
end
