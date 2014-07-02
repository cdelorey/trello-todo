require 'spec_helper'
require 'yaml'

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

  context "database" do 
    before(:all) do
      @cards = YAML::load(IO.read("spec/fixtures/test_cards.yaml"))
    end

    it "is initially empty" do
      expect(Card.count).to eq 0
    end

    context "adding cards" do
      before(:each) { store_cards_in_database(@cards) }

      it "stores correct number of cards" do
        expect(Card.count).to eq @cards.size
      end

      it "stores cards with correct names" do
        Card.all(:fields => [:name]).each do |card|
          expect(["Learn SQL the Hard Way", "Data Structures and Algorithms in C++"])
          .to include(card.name)
        end 
      end
    end

    context "when card is already stored" do 
      it "does not store the card" do
        store_cards_in_database(@cards.first)
        store_cards_in_database(@cards.first)
        expect(Card.count).to eq(1)
      end 
    end

  end

end