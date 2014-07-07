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

 #belongs_to :card 
end


module Tasks
  extend self

  # retrieves all tasks from the programming project in Todoist
  def get_tasks_from_todoist
    return Todoist::Task.uncompleted(PROGRAMMING_PROJECT_ID)
  end

  # creates tasks from card names and sends them to todoist
  def create_todoist_tasks(cards)
    tasks = []
    if cards.respond_to?(:count)
      cards.each do |card|
        tasks << Todoist::Task.create(card.name, PROGRAMMING_PROJECT_ID)
      end
    else
      tasks << Todoist::Task.create(cards.name, PROGRAMMING_PROJECT_ID)
    end
    return tasks
  end

  # returns true if a task with the given name is in the database
  def task_in_database?(name)
    return Task.first(:name => name) != nil
  end

  def create_task(id, name) 
    unless(task_in_database?(name))
      puts Task.create(:id =>id, :name => name).saved?
    end
  end

  def store_tasks_in_database(tasks)
    tasks.each do |task|
      create_task(task.id, task.content)
    end
  end
end
