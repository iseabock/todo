# frozen_string_literal: true

require 'rails_helper'

feature 'Editing a task' do
  let!(:project) { Project.create(name: 'Test Project') }
  let!(:task) { Task.create(name: 'Test my app', completed: false, project_id: project.id) }

  before(:each) do
    user = User.create!(email: 'example@example.com', password: 'letmein')
    visit root_path(as: user)
  end

  scenario 'redirects to the tasks index page on success' do
    visit project_tasks_path(project_id: 1)
    click_on 'Edit'
    expect(page).to have_content('Editing task')

    fill_in 'Name', with: 'Test my app (updated)'
    click_button 'Save'

    expect(page).to have_content('Tasks')
    expect(page).to have_content('Test my app (updated)')
  end

  scenario 'displays an error when no name is provided' do
    visit edit_project_task_path(project, task)
    fill_in 'Name', with: ''
    click_button 'Save'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'lets the user complete a task' do
    visit edit_project_task_path(project, task)
    check 'Completed'
    click_button 'Save'

    visit project_tasks_path(project)
    click_link 'All'
    expect(page).to have_content('true')
  end
end
