require 'spec_helper'
  
describe Task do        

  let(:task) { FactoryGirl.create(:task) }
  subject { task }

  it { should respond_to(:id) }
  it { should respond_to(:name) }

  context "Getting tasks from Todoist", :api => true do
    let(:tasks) { get_tasks_from_todoist }
    let(:task_names) { tasks.map { |task| task.content } }

    it "gets correct cards" do
      expect(task_names).to include("Databases")
    end

    it "gets cards from correct project" do
      expect(tasks.first.project_id).to eq(PROGRAMMING_PROJECT_ID)
    end
  end

end