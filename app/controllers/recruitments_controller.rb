# frozen_string_literal: true

class RecruitmentsController < ApplicationController
  before_action :recruitment, only: %i[destroy edit update]
  before_action :company, only: %i[new create edit update]
  before_action :redirect_path, only: %i[create update]

  def show; end

  def new
    redirect_to companies_path and return unless turbo_frame_request?

    @recruitment = @company.recruitments.build

    @recruitment.build_recruitment_role
  end

  def edit; end

  def create
    @recruitment = Recruitment.new(recruitment_params)

    return handle_success_response(@redirect_path) if @recruitment.save

    handle_error_response(@recruitment)
  end

  def update
    return handle_success_response(@redirect_path) if @recruitment.update(recruitment_params)

    handle_error_response(@recruitment)
  end

  def destroy
    company_id = @recruitment.company_id

    @recruitment.destroy

    redirect_to company_path(company_id), notice: I18n.t('recruitments.delete.flashes.success')
  end

  private

  def redirect_path
    @redirect_path = company_path(id: recruitment_params[:company_id] || @recruitment.company_id)
  end

  def recruitment
    @recruitment = Recruitment.find(params[:id])
  end

  def company
    @company = Company.find(params[:company_id] || params.dig(:recruitment, :company_id) || @recruitment.company_id)
  end

  def recruitment_params
    params.require(:recruitment).permit(
      :description,
      :company_id,
      :status,
      :value,
      :opening_date,
      :finish_date,
      recruitment_role_attributes: [
        :id,
        { roles_data: {} }
      ]
    )
  end
end
