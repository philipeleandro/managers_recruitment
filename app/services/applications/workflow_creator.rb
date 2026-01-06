# frozen_string_literal: true

module Applications
  class WorkflowCreator
    def initialize(recruitment_role, candidate_params = {})
      @candidate_params = candidate_params
      @recruitment_role = recruitment_role
    end

    def self.call(recruitment_role, candidate_params = {})
      new(recruitment_role, candidate_params).call
    end

    def call
      ActiveRecord::Base.transaction do
        find_or_create_candidate
        validate_existing_application!
        update_candidate
        create_application
      end

      { resource: @application }
    rescue ActiveRecord::RecordInvalid => e
      message = e.message.split(':').last

      { resource: Candidate.new(@candidate_params), errors: message.split(',') }
    rescue StandardError
      { resource: Candidate.new(@candidate_params), errors: error_message }
    end

    private

    def validate_existing_application!
      @application = Application.exists?(
        candidate_id: @candidate.id,
        recruitment_role_id: @recruitment_role.id
      )

      raise StandardError if @application
    end

    def create_application
      @application = Application.create!(
        candidate_id: @candidate.id,
        recruitment_role_id: @recruitment_role.id
      )
    end

    def find_or_create_candidate
      return create_candidate if find_candidate_by_cpf.nil?

      @candidate
    end

    def create_candidate
      @candidate ||= Candidate.create!(@candidate_params)

      @candidate
    end

    def update_candidate
      @candidate.update(@candidate_params)
    end

    def find_candidate_by_cpf
      @candidate = Candidate.find_by(cpf: @candidate_params[:cpf])
    end

    def error_message
      return I18n.t('services.applications.workflow_creator.existing_apply') if @application

      I18n.t('services.applications.workflow_creator.error')
    end
  end
end
