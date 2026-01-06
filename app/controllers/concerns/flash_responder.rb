# frozen_string_literal: true

module FlashResponder
  extend ActiveSupport::Concern

  def handle_error_response(resource, errors_message = nil)
    flash.now[:alert] = errors_message || resource.errors.full_messages

    respond_to do |format|
      format.turbo_stream { render_turbo_stream(:unprocessable_entity) }
      format.html { render template_by_action_name, status: :unprocessable_entity }
    end
  end

  def handle_success_response(redirect_path = nil)
    message = I18n.t("#{controller_name}.#{action_name}.flashes.success")
    flash.now[:notice] = message

    respond_to do |format|
      redirect_path ||= url_for(controller: controller_name, action: :index)

      return redirect_to redirect_path, notice: message unless turbo_frame_request?

      format.turbo_stream { render_turbo_stream }
    end
  end

  private

  def template_by_action_name
    return "#{controller_name}/edit" if action_name == 'update'

    "#{controller_name}/new"
  end

  def render_turbo_stream(status = :ok)
    render turbo_stream: [
      turbo_stream.update('flash-messages', partial: 'shareds/flashes'),
      turbo_stream.replace(turbo_frame_request_id, template: template_by_action_name, layout: false)
    ], status: status
  end
end
