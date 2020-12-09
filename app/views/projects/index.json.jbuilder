# frozen_string_literal: true

json.array!(@projects) do |project|
  json.extract! project, :id, :name, :completed
  json.url project_url(project, format: :json)
end
