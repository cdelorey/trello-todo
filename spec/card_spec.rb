require 'spec_helper'

describe Card do
  
  let(:card) { FactoryGirl.create(:card) }
  subject { card }

  it { should respond_to(:id) }
  it { should respond_to(:name) }

end