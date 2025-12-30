# frozen_string_literal: true

module Roles
  class Filter
    LIMIT = 10

    def initialize(query, status, page)
      @query = query
      @status = status
      @page = page
    end

    def self.call(query:, status:, page:)
      new(query, status, page).call
    end

    def call
      resource = filtered_by_name_or_description
      resource = filtered_by_status(resource)

      resource.order(created_at: :desc).page(@page).per(LIMIT)
    end

    private

    def default_resources
      Role.all
    end

    def filtered_by_name_or_description
      return default_resources if @query.blank?

      default_resources.where(name_or_description_sql_query, query: "%#{@query}%")
    end

    def filtered_by_status(resource)
      return resource.where(status: @status) if @status.present?

      resource
    end

    def name_or_description_sql_query
      "
        unaccent(name) ILIKE unaccent(:query) OR
        unaccent(description) ILIKE unaccent(:query)
      "
    end
  end
end
