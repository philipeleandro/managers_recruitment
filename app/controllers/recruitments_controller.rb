# frozen_string_literal: true

class RecruitmentsController < ApplicationController
  def new
    unless turbo_frame_request?
      redirect_to companies_path and return
    end

    @recruitment = Recruitment.new(company_id: params[:company_id])
  end

  def create
    @recruitment = Recruitment.new(recruitment_params)

    return handle_success_response if @recruitment.save

    handle_error_response(@recruitment)
  end

  private

  def recruitment_params
    params.require(:recruitment).permit(:description, :company_id, :status, :value, :opening_date, :finish_date)
  end
end
