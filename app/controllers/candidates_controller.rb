# frozen_string_literal: true

class CandidatesController < ApplicationController
  before_action :candidate, only: %i[show edit update destroy]

  def index
    @candidates = ::Candidates::Filter.call(
      query: params[:query],
      status: params[:status],
      page: params[:page]
    )
  end

  def show
    @applications = Application.by_candidate(@candidate.id)
      .page(params[:page])
      .per(10)
  end

  def new
    @candidate = Candidate.new
  end

  def edit; end

  def create
    @candidate = Candidate.new(candidate_params)

    return handle_success_response if @candidate.save

    handle_error_response(@candidate)
  end

  def update
    return handle_success_response if @candidate.update(candidate_params)

    handle_error_response(@candidate)
  end

  def destroy
    @candidate.destroy

    redirect_to candidates_path, notice: I18n.t('candidates.delete.flashes.success')
  end

  private

  def candidate
    @candidate = Candidate.find(params[:id])
  end

  def candidate_params
    params.require(:candidate).permit(:name, :email, :cpf, :phone_number, :status, :resume)
  end
end
