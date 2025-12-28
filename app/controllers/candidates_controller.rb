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

    if @candidate.save
      return handle_success_response(
        template: 'candidates/new',
        message: 'Candidato criado com sucesso.',
        location: 'candidate_management',
        path_redirect: candidates_path
      )
    end

    handle_error_response(
      template: :new,
      message: @candidate.errors.full_messages,
      location: 'candidate_management',
      path_template: 'candidates/new'
    )
  end

  def update
    if @candidate.update(candidate_params)
      return handle_success_response(
        template: 'candidates/edit',
        message: 'Candidato atualizado com sucesso.',
        location: 'candidate_management',
        path_redirect: candidates_path
      )
    end

    handle_error_response(
      template: :edit,
      message: @candidate.errors.full_messages,
      location: 'candidate_management',
      path_template: 'candidates/edit'
    )
  end

  def destroy
    @candidate.destroy

    redirect_to candidates_path, notice: 'Candidato excluído com sucesso.'
  end

  private

  def candidate
    @candidate = Candidate.find(params[:id])
  end

  def candidate_params
    params.require(:candidate).permit(:name, :email, :cpf, :phone_number, :status, :resume)
  end
end
