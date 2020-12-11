# frozen_string_literal: true

class Project < ApplicationRecord
  has_paper_trail
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
end
