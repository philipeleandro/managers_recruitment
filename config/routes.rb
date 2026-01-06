# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  devise_for :admins

  root 'dashboards#home'
  resources :candidates
  resources :companies
  resources :roles
  resources :recruitments
  resources :applications

  get 'apply/:token' => 'applications#new', as: :apply
  post 'apply/:token' => 'applications#create'
  post 'apply/:id/reject' => 'applications#reject', as: :reject_application
  post 'apply/:id/approve' => 'applications#approve', as: :approve_application
  post 'recruitment/:recruitment_id/role/:role_id/open_to_apply' => 'recruitment_roles#open_to_apply',
    as: :open_to_apply
  post 'recruitment/:recruitment_id/role/:role_id/close_to_apply' => 'recruitment_roles#close_to_apply',
    as: :close_to_apply
end
