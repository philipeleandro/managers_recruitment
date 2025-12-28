# frozen_string_literal: true

class CandidatesController < ApplicationController
  before_action :candidate, only: %i[show edit update destroy]

  def index
    # passar para service
    @candidates = Candidate.all

    if params[:query].present?
      sql_query = "
        unaccent(name) ILIKE unaccent(:q) OR
        unaccent(email) ILIKE unaccent(:q) OR
        unaccent(cpf) ILIKE unaccent(:q)
      "
      @candidates = @candidates.where(sql_query, q: "%#{params[:query]}%")
    end

    @candidates = @candidates.where(status: params[:status]) if params[:status].present?
    @candidates = @candidates.order(created_at: :desc)
      .page(params[:page])
      .per(10)
  end

  def show
    @applications = []
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
