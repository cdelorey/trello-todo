require 'data_mapper'

PROGRAMMING_PROJECT_ID = 100222382

##
# Task
#
# A Todoist task.
class Task
 include DataMapper::Resource
 
 property :id, Integer, :key => true
 property :name, String, :required => true, :unique => true, :index => true

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
    unless cards.nil?
      # cards is a collection
      if cards.respond_to?(:count)
        cards.each do |card|
          id = Todoist::Task.create(card.name, PROGRAMMING_PROJECT_ID).id
          store_task_in_database(id, card)
        end
      # cards is a single card object
      else
        id = Todoist::Task.create(cards.name, PROGRAMMING_PROJECT_ID).id
        store_task_in_database(id, cards)
      end
    end
  end

  # takes a list of cards and removes all cards that are already stored as tasks in database
  def filter_tasks(cards)
    # cards is a collection
    if cards.respond_to?(:count)
      return cards.select do |card|
        Task.first(:name => card.name) == nil
      end
    # cards is a single card object  
    else
      if Task.first(:name => cards.name) == nil
        return cards 
      else 
        return nil 
      end
    end
  end

  def store_task_in_database(task_id, card)
    Task.create(:id =>task_id, :name => card.name, :card_id => card.id)
  end
end