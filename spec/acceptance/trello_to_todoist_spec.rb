require 'acceptance/acceptance_helper'

feature "Trello to Todoist" do
  
  background do
    visit '/trello'
  end

  # Should actually call apis. This is necesary only for the acceptance test. 
  # Specs will use vcr.
  given(:card) { get_trello_cards.first }
  given(:task_names) { get_todoist_task_names } 

  scenario "Moving Trello card names to todoist tasks" do
    expect(task_names).to include(card.name)
  end

  scenario "Moving Trello card names that are already todoist tasks" do
  end

  scenario "Moving Trello checklist items to todoist subtasks" do
  end

  scenario "Moving Trello checklist items that are already todoist subtasks" do
  end


end