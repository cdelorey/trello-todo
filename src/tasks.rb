require 'data_mapper'

PROGRAMMING_PROJECT_ID = 100222382

##
# Task
#
# A Todoist task.
class Task
 include DataMapper::Resource
 
 property :id, Integer, :key => true  # task id created by todoist
 property :name, String, :required => true, :unique => true, :index => true
 property :subtask, Boolean       

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
    cards = filter_tasks(cards)
    if cards
      cards.each do |card|
        id = Todoist::Task.create(card.name, PROGRAMMING_PROJECT_ID).id
        store_task_in_database(id, card)
      end
    end
  end

  # takes a list of cards and removes all cards that are already stored as tasks in database
  def filter_tasks(cards)
    cards = Array(cards) unless cards.respond_to?(:count)
    return cards.select { |card| Task.first(:name => card.name).nil? } #TODO: move this to method with descriptive name
  end

  def store_task_in_database(task_id, card)
    Task.create(:id =>task_id, :name => card.name, :card_id => card.id)
  end

  def delete_task(card)
    task = Task.first(:card_id => card.id)
    delete_tasks_from_todoist(Array(card.id))
    task.destroy
  end

  def delete_tasks_from_todoist(ids)
    Todoist::Base.put('/deleteItems', :query => {ids: ids.to_json})
  end

  # removes all tasks from database and deletes corresponding task in todoist
  def remove_all_tasks
    ids = []
    Task.all.each { |task| ids << task.id }
    delete_tasks_from_todoist(ids)
    Task.destroy
  end
end