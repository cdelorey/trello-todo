require 'spec_helper'
  
describe Task do        

  let(:task) { FactoryGirl.create(:task) }
  subject { task }

  it { should respond_to(:id) }
  it { should respond_to(:name) }

end