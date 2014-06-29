require File.expand_path '../spec_helper.rb', __FILE__
require 'trello'
require 'todoist'

describe "Trello-Todo App" do 
  it "allows accessing the main page" do
    get '/'
    expect(last_response).to be_ok
  end

  it "connects to Trello" do
    me = Member.find("me")
    expect(me).to respond_to(:username)
  end

  it "connects to Todoist" do
    projects = Todoist::Project.all
    expect(projects.first).to respond_to(:name)
  end
end