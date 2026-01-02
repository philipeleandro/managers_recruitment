# frozen_string_literal: true

class DashboardsController < ApplicationController
  def home
    @recruitments = ::Recruitments::Filter.call(
      status: params[:status],
      page: params[:page],
      sort: params[:sort],
      direction: params[:direction]
    )
  end
end
