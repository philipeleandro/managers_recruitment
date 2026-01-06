# frozen_string_literal: true

class RolesController < ApplicationController
  before_action :role, only: %i[show edit update destroy]

  def index
    @roles = ::Roles::Filter.call(
      query: params[:query],
      status: params[:status],
      page: params[:page]
    )
  end

  def show; end

  def new
    redirect_to companies_path and return unless turbo_frame_request?

    @role = Role.new(company_id: params[:company_id])
  end

  def edit; end

  def create
    @role = Role.new(role_params)
    path = company_path(id: role_params[:company_id])

    return handle_success_response(path) if @role.save

    handle_error_response(@role)
  end

  def update
    return handle_success_response if @role.update(role_params)

    handle_error_response(@role)
  end

  def destroy
    company_id = @role.company_id

    if @role.destroy
      return redirect_to company_path(id: company_id),
        notice: I18n.t('candidates.delete.flashes.success')
    end

    flash[:alert] = @role.errors.full_messages

    redirect_to company_path(id: company_id)
  end

  private

  def role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name, :description, :company_id, :status)
  end
end
