# frozen_string_literal: true

require 'rails_helper'

describe Project, type: :model do
  context 'with no name' do
    it 'is invalid' do
      project = Project.new
      expect(project).to_not be_valid
    end
  end
end
