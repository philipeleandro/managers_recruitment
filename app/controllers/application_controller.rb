# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include FlashResponder

  layout :layout_by_resource

  before_action :authenticate_admin!, unless: :devise_controller?

  allow_browser versions: :modern

  stale_when_importmap_changes

  def after_sign_in_path_for(resource)
    authenticated_root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def layout_by_resource
    return 'public' if devise_controller? || controller_name == 'applications'

    'application'
  end
end
