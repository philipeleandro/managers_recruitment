# frozen_string_literal: true

module Recruitments
  class RolesSearcher
    LIMIT = 10

    def initialize(resource, page)
      @resource = resource
      @page = page
    end

    def self.call(resource:, page:)
      new(resource, page).call
    end

    def call
      roles
    end

    private

    def roles
      @resource.roles
        .order(created_at: :desc)
        .page(@page)
        .per(LIMIT)
    end
  end
end
