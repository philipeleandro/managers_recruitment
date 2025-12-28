# frozen_string_literal: true

class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  stale_when_importmap_changes

  private

  def handle_error_response(template:, message:, location:, path_template:)
    flash.now[:alert] = message

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update('flash-messages', partial: 'shareds/flashes'),
          turbo_stream.replace(location, template: path_template, layout: false)
        ], status: :unprocessable_entity
      end

      format.html { render template, status: :unprocessable_entity }
    end
  end

  def handle_success_response(message:, template:, location:, path_redirect:)
    flash.now[:notice] = message

    respond_to do |format|
      return redirect_to path_redirect, notice: message unless turbo_frame_request?

      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update('flash-messages', partial: 'shareds/flashes'),
          turbo_stream.replace(location, template: template, layout: false)
        ]
      end
    end
  end
end
