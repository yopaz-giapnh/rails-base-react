# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "users#welcome"
  get "users/index"
end
