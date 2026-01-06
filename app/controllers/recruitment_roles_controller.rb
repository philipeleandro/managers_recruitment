# frozen_string_literal: true

class RecruitmentRolesController < ApplicationController
  before_action :recruitment_role, only: %i[open_to_apply close_to_apply]

  def open_to_apply
    @recruitment_role.open_to_applications!

    flash[:notice] = I18n.t('recruitment_roles.open_to_applications.success')
  rescue StandardError => e
    flash[:error] = e.message
  ensure
    redirect_to recruitment_path(id: @recruitment_role.recruitment_id)
  end

  def close_to_apply
    @recruitment_role.closed_to_applications!

    flash[:notice] = I18n.t('recruitment_roles.close_to_applications.success')
  rescue StandardError => e
    flash[:error] = e.message
  ensure
    redirect_to recruitment_path(id: @recruitment_role.recruitment_id)
  end

  private

  def recruitment_role
    @recruitment_role = RecruitmentRole.find_by(
      recruitment_id: params[:recruitment_id],
      role_id: params[:role_id]
    )
  end
end
