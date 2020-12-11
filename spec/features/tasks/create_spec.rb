# frozen_string_literal: true

require 'rails_helper'

feature 'Creating a task' do
  before(:each) do
    user = User.create!(email: 'example@example.com', password: 'letmein')
    visit root_path(as: user)
  end

  let!(:project) { Project.create(name: 'Test Project') }
  scenario 'redirects to the tasks index page on success' do
    visit project_tasks_path(project)
    click_on 'Add a task'
    expect(page).to have_content('Create a task')

    fill_in 'Name', with: 'Test my app'
    click_button 'Save'

    expect(page).to have_content('Tasks')
    expect(page).to have_content('Test my app')
  end

  scenario 'displays an error when no name is provided' do
    visit new_project_task_path(project)
    fill_in 'Name', with: ''
    click_button 'Save'

    expect(page).to have_content("Name can't be blank")
  end
end
