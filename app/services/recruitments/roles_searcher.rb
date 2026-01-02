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
      return [] unless valid_recruitment_role?

      roles
    end

    private

    def recruitment_role
      @recruitment_role ||= @resource.recruitment_role
    end

    def valid_recruitment_role?
      return false if recruitment_role.nil?
      return false if recruitment_role.roles_data.blank?

      true
    end

    def role_ids
      recruitment_role.roles_data.keys.map(&:to_i)
    end

    def roles
      Role.where(id: role_ids)
          .order(created_at: :desc)
          .page(@page)
          .per(LIMIT)
    end
  end
end
