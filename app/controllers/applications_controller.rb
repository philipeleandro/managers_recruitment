# frozen_string_literal: true

class ApplicationsController < ApplicationController
  layout 'public'

  before_action :recruitment_role, only: %i[new create]
  before_action :application, only: %i[approve reject]

  def new
    render :invalid_recruitment if @recruitment_role.nil?
  end

  def create
    service = ::Applications::WorkflowCreator.call(@recruitment_role, candidate_params)

    return handle_error_response(service[:resource], service[:errors]) if service[:errors]

    redirect_to apply_path(token: @recruitment_role.token),
      notice: I18n.t('applications.create.apply.success')
  end

  def reject
    @application.rejected!

    flash[:notice] = I18n.t('applications.reject.success')
  rescue StandardError => e
    flash[:error] = e.message
  ensure
    redirect_to recruitment_path(id: @application.recruitment_role.recruitment_id)
  end

  def approve
    @application.approved!

    flash[:notice] = I18n.t('applications.approve.success')
  rescue StandardError => e
    flash[:error] = e.message
  ensure
    redirect_to recruitment_path(id: @application.recruitment_role.recruitment_id)
  end

  private

  def application
    @application = Application.find(params[:id])
  end

  def recruitment_role
    @recruitment_role = RecruitmentRole.find_by(
      token: params[:token],
      status: RecruitmentRole::Status::OPEN_TO_APPLICATIONS
    )
  end

  def candidate_params
    params.permit(:name, :email, :cpf, :phone_number, :status, :resume)
  end
end
