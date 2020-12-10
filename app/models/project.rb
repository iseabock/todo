class Project < ApplicationRecord
    has_paper_trail
    has_many :tasks, dependent: :destroy
end
