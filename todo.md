# Outline:

### Trello -> Todoist
- add method to delete todoist tasks
- delete todoist tasks made during tests
- add checklist items on cards as subtasks for card's main task in 
	- only add first task on checklist to todoist
	- when a subtask is checked off:
		- add next task in checklst if it exists
		- move card to done list otherwise (only if a checklist exists)
- add support for multiple checklists
- remove subtasks when deleting main task in todoist
- only add checklist items if they are not already in tasks database
- move to host

### Todoist -> Trello 
- detect if site is todoist or trello, run appropriate script
- once item is done in todoist, move card to "Done" list
- once item on checklist is done in todoist, check it off in trello checklist
- if item in checklist is last item to be checked on card, move card to "Done" list
  - (if badges.checkItemsChecked === badges.checkItems) 

### Generalize 
- use cards from all "Doing" lists on every board

### Maybe
- configure which lists/boards to use
- add different todo app apis 


_______________________________________________________________________________
_______________________________________________________________________________

# Log:

#### 06/25/14 
__DONE__ sinatra app skeleton
__DONE__ setup rspec
__DONE__ setup capybara acceptance testing 

#### 06/28/14
__DONE__ connect to Trello
__DONE__ connect to Todoist
__DONE__ create card model

### 06/29/14
__DONE__ setup code coverage tool
__DONE__ fix database issue 
__DONE__ setup database_cleaner

### 06/30/14
__DONE__ tag all tests that make api calls

### 07/01/14
__DONE__ get all cards from doing list

### 07/02/14
__DONE__ save list of cards currently in doing to database
__DONE__ fix database issue
__DONE__ cache api results for relevant tests
__DONE__ fix bug with adding a single card to database
__DONE__ only add todo items for cards that are not already in list in database

### 07/03/14
__DONE__ create task model

### 07/05/14
__DONE__ get tasks from todoist
__DONE__ filter cards based on presence in database
__DONE__ turn names of all cards in Doing list into todo items in todoist

### 07/07/14
__DONE__ store tasks in database
__DONE__ - check if task is already in database before adding a new one (will have to use
            names, since ids will be different every time)

### 07/08/14
__DONE__ associate cards with tasks
__DONE__ fix task validations

### 07/11/14
__DONE__ automatically assign all cards in doing list to me

### 07/15/14
__DONE__ fix bug with adding todoist tasks
__DONE__ fix handling of array of cards vs single card
__DONE__ add way to delete things added to trello or todoist during tests
__DONE__ move cards from doing list to done list

### 10/28/14
__DONE__ add method to restore completed tasks to doing list
__DONE__ restore cards to test list after test that moves them
__DONE__ remove items from database once they have been removed from doing list
__DONE__ remove todoist tasks attached to card once card has been removed from doing list
__DONE__ add method to get a card's first unchecked list item 

### 10/30/14
__DONE__ change get_first_unchecked_item to take an array of check_items instead of an entire card
__DONE__ refactor task creation


