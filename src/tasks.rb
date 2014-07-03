require 'data_mapper'

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