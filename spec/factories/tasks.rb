# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { 'MyTask' }
    completed { false }
  end
end
