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
        create_todoist_tasks(@cards) 
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

      context "When task is already stored", :api => true do
        it "does not store the task" do
          create_todoist_tasks(@cards.first)
          expect(Task.count).to eq(2)
        end

        it "does not send a new task to todoist", :api => true do
          task_count_before = get_tasks_from_todoist.count
          create_todoist_tasks(@cards.first)
          task_count_after = get_tasks_from_todoist.count
          expect(task_count_after).to eq(task_count_before)
        end
      end
    end    
  end
end