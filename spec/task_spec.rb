require 'spec_helper'
  
describe Task do        

  let(:task) { FactoryGirl.create(:task) }
  subject { task }

  it { should respond_to(:id) }
  it { should respond_to(:name) }

  context "Getting tasks from Todoist", :api => true do
    pp Todoist::Project.all
  end

end