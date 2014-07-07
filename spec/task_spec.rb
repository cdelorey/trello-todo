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

  context "Database" do
    before(:all) do
      @cards = YAML::load(IO.read("spec/fixtures/test_cards.yaml"))
    end

    it "is initially empty" do
      expect(Task.count).to eq 0
    end


    context "Adding Tasks" do
      before(:each) do
        tasks = create_todoist_tasks(@cards) 
        store_tasks_in_database(tasks) 
      end

      it "should not be empty" do
        expect(Task.count).to be > 0
      end

      it "stores tasks with correct names" do
        Task.all(:fields => [:name]).each do |task|
          expect(["Learn SQL the Hard Way", "Data Structures and Algorithms in C++"])
          .to include(task.name)
        end 
      end

      context "When task is already stored" do
        it "does not store the task" do
          task = create_todoist_tasks(@cards.first)
          store_tasks_in_database(task)
          expect(Task.count).to eq(2)
        end
      end
    end    
  end
end