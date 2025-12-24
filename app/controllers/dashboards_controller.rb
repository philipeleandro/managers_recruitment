# frozen_string_literal: true

class DashboardsController < ApplicationController
  def home
    @open_processes = []
  end
end
