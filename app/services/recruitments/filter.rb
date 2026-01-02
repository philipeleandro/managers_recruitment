# frozen_string_literal: true

module Recruitments
  class Filter
    LIMIT = 10

    def initialize(status, page, sort, direction, company_id)
      @status = status
      @page = page
      @sort = sort
      @direction = direction
      @company_id = company_id
    end

    def self.call(status:, page:, sort:, direction:, company_id: nil)
      new(status, page, sort, direction, company_id).call
    end

    def call
      resource = default_resources
      resource = load_recruitment_roles(resource)
      resource = filtered_by_status(resource)
      resource = sorted_resources(resource, @sort, @direction)

      resource.order(created_at: :desc).page(@page).per(LIMIT)
    end

    private

    def default_resources
      return Recruitment.all if @company_id.nil?

      Recruitment.where(company_id: @company_id)
    end

    def sorted_resources(resource, sort, direction)
      return resource if sort.blank? && direction.blank?

      resource.order(sort.to_sym => direction.to_sym)
    end

    def filtered_by_status(resource)
      return resource.where(status: @status) if @status.present?

      resource
    end

    def load_recruitment_roles(resource)
      resource.includes(:recruitment_role)
    end
  end
end
