# frozen_string_literal: true

module Companies
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
      resource = filtered_by_name_or_email_or_cpf_or_responsible_name
      resource = filtered_by_status(resource)

      resource.order(created_at: :desc).page(@page).per(LIMIT)
    end

    private

    def default_resources
      Company.all
    end

    def filtered_by_name_or_email_or_cpf_or_responsible_name
      return default_resources if @query.blank?

      default_resources.where(name_or_email_or_cnpj_or_responsible_name_sql_query, query: "%#{@query}%")
    end

    def filtered_by_status(resource)
      return resource.where(status: @status) if @status.present?

      resource
    end

    def name_or_email_or_cnpj_or_responsible_name_sql_query
      "
        unaccent(name) ILIKE unaccent(:query) OR
        unaccent(responsible_name) ILIKE unaccent(:query) OR
        unaccent(email) ILIKE unaccent(:query) OR
        unaccent(cnpj) ILIKE unaccent(:query)
      "
    end
  end
end
