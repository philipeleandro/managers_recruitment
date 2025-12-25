# frozen_string_literal: true

class CandidatesController < ApplicationController
  before_action :candidate, only: %i[edit]

  def index
    @candidates = Candidate.all
    @candidates = @candidates.where(status: params[:status]) if params[:status].present?
    @candidates = @candidates.order(created_at: :desc)
                             .page(params[:page])
                             .per(10)
  end

  def new
    @candidate = Candidate.new
  end

  def edit; end

  private

  def candidate
    @candidate = Candidate.find(params[:id])
  end
end
