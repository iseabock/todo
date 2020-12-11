# frozen_string_literal: true

Rails.application.routes.draw do
  resources :projects do
    resources :tasks do
      get 'versions', to: 'tasks#versions'
      get 'version/:version_id', to: 'tasks#version', as: 'version'
    end
  end

  root to: 'projects#index'
end
