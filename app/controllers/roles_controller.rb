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

  def show
    # futuramente vai ter os candidatos atrelados
    @roles = []
  end

  def new
    redirect_to companies_path and return unless turbo_frame_request?

    @role = Role.new(company_id: params[:company_id])
  end

  def edit; end

  def create
    @role = Role.new(role_params)

    return handle_success_response if @role.save

    handle_error_response(@role)
  end

  def update
    return handle_success_response if @role.update(role_params)

    handle_error_response(@role)
  end

  def destroy
    @role.destroy

    redirect_to company_path(id: params[:company_id]), notice: I18n.t('roles.delete.flashes.success')
  end

  private

  def role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name, :description, :company_id, :status)
  end
end
