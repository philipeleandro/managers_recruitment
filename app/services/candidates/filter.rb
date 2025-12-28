module Candidates
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
      resource = filtered_by_name_or_email_or_cpf
      resource = filtered_by_status(resource)

      resource.order(created_at: :desc).page(@page).per(LIMIT)
    end

    private

    def default_resources
      Candidate.all
    end

    def filtered_by_name_or_email_or_cpf
      return default_resources unless @query.present?

      default_resources.where(name_or_email_or_cpf_sql_query, query: "%#{@query}%")
    end

    def filtered_by_status(resource)
      return resource.where(status: @status) if @status.present?

      resource
    end

    def name_or_email_or_cpf_sql_query
      "
        unaccent(name) ILIKE unaccent(:query) OR
        unaccent(email) ILIKE unaccent(:query) OR
        unaccent(cpf) ILIKE unaccent(:query)
      "
    end
  end
end
