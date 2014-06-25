# Outline:
---------

### Setup
- setup rspec 

### Trello -> Todoist
- connect to Trello
- get all cards from doing list
- automatically assign all cards in doing list to me
- connect to todoist
- turn names of all cards into todo items in todoist
- save list of cards currently in doing to local storage
- only add todo items for cards that are not already in list in local storage
- remove items from local storage once they have been removed from list
- add checklist items on cards as subtasks for card's main task in todoist
- move to host

### Todoist -> Trello 
- detect if site is todoist or trello, run appropriate script
- once item is done in todoist, move card to "Done" list
- once item on checklist is done in todoist, check it off in trello checklist
- if item in checklist is last item to be checked on card, move card to "Done" list
  - (if badges.checkItemsChecked === badges.checkItems) 

### Generalize 
- use cards from all "Doing" lists on every board
- add forms on project index.html to configure which lists/boards to use (MAYBE)
- add different todo app apis (maybe)


_______________________________________________________________________________
_______________________________________________________________________________

# Log:
---------

#### 06/25/14 
__DONE__ sinatra app skeleton

