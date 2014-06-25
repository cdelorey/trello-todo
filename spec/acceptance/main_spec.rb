require 'acceptance/acceptance_helper'

feature "TEST" do
  
  scenario "this is a test" do
    visit '/'
    expect(page).to have_content "It works."
  end

end