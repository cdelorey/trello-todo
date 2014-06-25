require File.expand_path '../spec_helper.rb', __FILE__


describe "Trello-Todo App" do 
  it "allows accessing the main page" do
    get '/'
    expect(last_response).to be_ok
  end
end