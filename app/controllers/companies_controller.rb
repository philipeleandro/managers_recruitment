# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :company, only: %i[show edit update destroy]

  def index
    @companies = ::Companies::Filter.call(
      query: params[:query],
      status: params[:status],
      page: params[:page]
    )
  end

  def show
    @roles = company.roles.order(created_at: :desc).page(params[:page]).per(10) # vai ser o recruitment roles dps
  end

  def new
    @company = Company.new
  end

  def edit; end

  def create
    @company = Company.new(company_params)

    return handle_success_response if @company.save

    handle_error_response(@company)
  end

  def update
    return handle_success_response if @company.update(company_params)

    handle_error_response(@company)
  end

  def destroy
    @company.destroy

    redirect_to companies_path, notice: I18n.t('companies.delete.flashes.success')
  end

  private

  def company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :email, :cnpj, :phone_number, :status, :responsible_name)
  end
end
