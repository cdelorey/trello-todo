require 'spec_helper'
require 'yaml'

describe Card do
  
  let(:card) { FactoryGirl.create(:card) }
  subject { card }

  it { should respond_to(:id) }
  it { should respond_to(:name) }


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

  context "filtering cards" do 
    before(:each) do 
      @card_in_database = Card.create!(:id => '12345a', :name => "test_card")
      @card_not_in_database = Card.new
      @card_not_in_database.attributes = { :id => '6789b', :name => "test_card_2" }
      @cards = [@card_in_database, @card_not_in_database]
    end

    it "returns cards that are not yet in the database" do
      expect(filter_cards(@cards)).to include(@card_not_in_database) 
    end

    it "does not return cards that are already in the database" do 
      expect(filter_cards(@cards)).not_to include(@card_in_database)
    end
  end

  context "assigning cards", :api => true do

    it "assigns all cards in doing list to me" do 
      cards = get_cards_from_trello
      assign_cards_to_me(cards)     
      wait 20 do
        cards = get_cards_from_trello  
        cards.each do |card|
          expect(card.members).not_to eq(nil)
          expect(card.members.first.username).to eq("cdelorey")
        end
      end
      unassign_me_from_cards(cards)
    end

    it "unassigns me from card when moved from doing list" do 

    end
  end

  context "moving cards from 'Doing' list to 'Done' list", :api => true do
    before(:all) do
      @cards = get_cards_from_trello
      move_cards_from_trello_to_todoist
      @moved_card = Card.get(@cards.first.id)
      @task = @moved_card.tasks.first
      move_to_done_list(@moved_card)
    end

    it "is no longer in the Doing list" do
      cards = Trello::List.find(DOING_LIST_ID).cards
      card_ids = cards.map { |card| card.id }
      expect(card_ids).not_to include(@moved_card.id) 
    end

    it "is in the 'Done' list" do
      cards = Trello::List.find(DONE_LIST_ID).cards
      card_ids = cards.map { |card| card.id }
      expect(card_ids).to include(@moved_card.id) 
    end

    it "is deleted from the database" do
      expect(Card.get(@moved_card.id)).to eq(nil)
    end

    specify "its associated task is deleted from task database" do
      expect(Task.get(@task)).to eq(nil)
    end

    specify "its associated task is deleted from todoist" do
    end
  end

end