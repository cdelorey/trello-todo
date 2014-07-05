require 'data_mapper'

PROGRAMMING_PROJECT_ID = 100222382

##
# Task
#
# A Todoist task.
class Task
 include DataMapper::Resource
 
 property :id, String, :key => true
 property :name, String, :required => true

 # belongs_to, :card 
end


module Tasks
  # retrieves all tasks from the programming project in Todoist
  def get_tasks_from_todoist
    return Todoist::Task.uncompleted(PROGRAMMING_PROJECT_ID)
  end
end