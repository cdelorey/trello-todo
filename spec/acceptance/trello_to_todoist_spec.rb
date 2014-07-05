require 'acceptance/acceptance_helper'

feature "Trello to Todoist" do
  
  background do
    #visit '/trello'
  end

  given(:card) { get_cards_from_trello.first }
  given(:tasks) { get_tasks_from_todoist } 

  scenario "Moving Trello card names to todoist tasks" do
    move_cards_from_trello_to_todoist
    task_names = tasks.map { |task| task.content }
    expect(task_names).to include(card.name)
  end

  scenario "Moving Trello card names that are already todoist tasks" do
  end

  scenario "Moving Trello checklist items to todoist subtasks" do
  end

  scenario "Moving Trello checklist items that are already todoist subtasks" do
  end


end