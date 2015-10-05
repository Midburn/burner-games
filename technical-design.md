# The Burner Games

A simple trivia for Midburn.org Tickets purchase process. The purpose behind such trivia game is to increase awareness of the burning man 10 principles, the nature of the Midburn festival, guidance for new participants how to act during the event.

The trivia will be fun, easy to solve and educating.

### Roles:

1. Each Burning Man principles will have couple of questions in the system.
2. User should answer at least 10 questions right in a successful game.
3. Each game will be randomize easy and hard questions to answer.
4. Each game will include questions from 10 categories. A successful game will include answers from all categories.
5. Each game may have as much questions as needed. The game will stop after 10 questions will be answered correctly.

##### Users will be referred to play the game when:
1. When opening a new Midburn profile.
2. When buying a Midburn Festival Ticket.
3. When receiving a ticket from a different Midburn profile.

## Technical Spec - Architecture Design

### Backend

* Ruby on Rails
* MySQL
* Rspec

### User Interface

* HTML hosted on API's Assets pipeline
* AngularJS
* Javascript library to communicate with API


## Technical Spec - Models

### Game Model

Facts:
* Game id will be generated for every time the game is about to be played.
* Game will be associated to a foreign user model in a one to many relation - 1 user may have multiple games 'played'.
* Each game will have a set of correctly answered questions and incorrectly answered questions. New randomized questions will not be part of those sets.
* Games are resumable (within a certain time) or can get abandoned. This will be determine by the game's status ```[on-going, finished, expired]```

### Question Model

There are 3 types of questions:
* Text question
* Image answers question
* Image question

Facts:
* A question's level will be one of the following ```[easy, medium, hard]```
* A question's category will be set on one of the following categories:
```
["inclusion", "gifting", "decommodification", "radical-self-reliance", "radical-self-expression", "communal-effort", "civic-responsibility", "leaving-no-trace", "participation", "immediacy", "other"]
```
* Each question has a set of answers (correct or incorrect answers).
* Each question has a set of **CORRECT** answers.
* Answers are a coupled sub-class of question.


## API
Games can be created, played and be tested using a standard modern CRUD RESTful API model. This decouples the user interface and the control layer of the games.

#### General responses

###### Good API response:
```
{ "status": "ok"}
```

###### An error API response:
```
{ "status": "error", "message": "you are trying to do something wrong"}
```

## Technical Spec - API Specs

#### `POST /games/new`
Creates a new game for a specified user. Will return the games token.

###### params
```
{
  "user_id": "678"
}
```
###### response
```
{ "status": "ok", "token": "gAm3_t0k3n"}
```

#### `GET /games/:token/next_question`

###### params
```
{
}
```

###### typical response
```
{
  "question": {
    "question_id": 45,
    "question_type": "text",
    "question_text": "What's the color of the sunrise while on acid?",
    "answers": [
      {"answer_id": 1, "answer_text": "Pinkish red"},
      {"answer_id": 2, "answer_text": "Greenish purple"},
      {"answer_id": 3, "answer_text": "The sun does not rise on the desert"},
      {"answer_id": 4, "answer_text": "Dolphins & unicorns"}
    ]
  }
  "status": "ok"
}
```

###### Next question response (if game was successfully over):
```
{ "status": "error", "message": "game is over, next question is not available"}
```

#### `GET /games/:token`
###### params
```
{
}
```

###### response
```
{
  "token": "gAm3_t0k3n",
  "game_status": "on-going"
}
```

##### `POST /question/:id/check`
```
{
  "answers": [1,2]
}
```

###### Correct response:
```
{
  "question_response": "correct",
  "status": "ok"
}
```

###### Incorrect response:
```
{
  "question_response": "incorrect",
  "status": "ok"
}
```
