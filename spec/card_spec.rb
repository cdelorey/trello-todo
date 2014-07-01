require 'spec_helper'

describe Card do
  
  let(:card) { FactoryGirl.create(:card) }
  subject { card }

  it { should respond_to(:id) }
  it { should respond_to(:name) }


  # these tests don't test the card model. 
  # they should probably be moved somewhere else.
  # TODO: refactor card method code
  context "getting cards from Trello", :api => true do
    let(:trello_card) { get_cards_from_trello.first } 
    let(:programming_board_id) { "5206965b344ba1b52f00060e" }
    let(:doing_list_id) { "5206965b344ba1b52f000610" }


    it "gets cards from correct board" do
      expect(trello_card.board_id).to eq(programming_board_id)
    end

    it "gets cards from correct list" do
      expect(trello_card.list_id).to eq(doing_list_id)
    end

  end

end