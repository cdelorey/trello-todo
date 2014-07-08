require 'data_mapper'

PROGRAMMING_PROJECT_ID = 100222382

##
# Task
#
# A Todoist task.
class Task
 include DataMapper::Resource
 
 property :id, Integer, :key => true
 property :name, String, :required => true

 belongs_to :card 
end


module Tasks
  extend self

  # retrieves all tasks from the programming project in Todoist
  def get_tasks_from_todoist
    return Todoist::Task.uncompleted(PROGRAMMING_PROJECT_ID)
  end

  # creates tasks from card names and sends them to todoist
  def create_todoist_tasks(cards)
    if cards.respond_to?(:count)
      cards.each do |card|
        id = Todoist::Task.create(card.name, PROGRAMMING_PROJECT_ID).id
        store_task_in_database(id, card)
      end
    else
      id = Todoist::Task.create(cards.name, PROGRAMMING_PROJECT_ID).id
      store_task_in_database(id, cards)
    end
  end

  # returns true if a task with the given name is in the database
  def task_in_database?(name)
    return Task.first(:name => name) != nil
  end

  def store_task_in_database(task_id, card)
    unless(task_in_database?(card.name))
      Task.create(:id =>task_id, :name => card.name, :card_id => card.id)
    end
  end
end
