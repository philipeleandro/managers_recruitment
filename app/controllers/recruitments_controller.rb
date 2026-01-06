# frozen_string_literal: true

class RecruitmentsController < ApplicationController
  before_action :recruitment, only: %i[show destroy edit update]
  before_action :company, only: %i[new create edit update]
  before_action :redirect_path, only: %i[create update]

  def show
    roles = @recruitment.roles.order(created_at: :desc)
    @role = params[:role_name].present? ? roles.find_by(name: params[:role_name]) : roles.first

    if @role.present?
      @applications = Application.by_recruitment_and_role(@recruitment.id, @role.id).page(params[:page]).per(10)
      @recruitment_role = RecruitmentRole.find_by(recruitment_id: @recruitment.id, role_id: @role.id)
    else
      @applications = Application.none.page(params[:page])
    end
  end

  def new
    redirect_to companies_path and return unless turbo_frame_request?

    @recruitment = @company.recruitments.build
  end

  def edit; end

  def create
    service = ::Recruitments::Creator.call(params)
    @recruitment = service[:resource]

    return handle_error_response(@recruitment, service[:errors]) if service[:errors]

    handle_success_response(@redirect_path)
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
      recruitment_roles_attributes: [
        :id,
        :role_id,
        :quantity
      ]
    )
  end
end
