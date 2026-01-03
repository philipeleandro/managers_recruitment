module Recruitments
  class Creator
    def initialize(params = {})
      @params = params
    end

    def self.call(params = {})
      new(params).call
    end

    def call
      ActiveRecord::Base.transaction do
        recruitment.save!
        recruitment_roles_creation
      end

      { resource: @recruitment }
    rescue ActiveRecord::RecordInvalid => e
      message = e.message.split(':').last

      { resource: @recruitment, errors: message.split(',') }
    rescue StandardError => e
      { resource: @recruitment, errors: e.message }
    end

    private

    def recruitment
      @recruitment ||= Recruitment.new(recruitment_params)
    end

    def recruitment_roles_creation
      recruitment_roles_data.each do |roles_data|
        RecruitmentRole.create!(recruitment_id: @recruitment.id, role_id: roles_data.first.to_i, quantity: roles_data.last.to_i)
      end
    end

    def recruitment_params
      @params.dig(:recruitment).permit(
        :description,
        :company_id,
        :status,
        :value,
        :opening_date,
        :finish_date)
    end

    def recruitment_roles_data
      recruitment_roles_params = @params.dig(:recruitment, :recruitment_role_attributes, :roles_data).permit!
      recruitment_roles_params = recruitment_roles_params.to_h.to_a
      cleaned_roles_data = recruitment_roles_params.map { |role_data| role_data unless role_data.last.to_i.zero? }

      return {} if cleaned_roles_data.compact.empty?

      cleaned_roles_data.compact
    end
  end
end
