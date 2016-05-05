# API Examples

## Models

### Game API Model
```
{
  "token": "t0k3n",          # The game's unique identifier
  "status": null,            # Status of the game: {started, ended, expired}
  "user_id": 22,             # The Midburn profile user id
  "completed": false,        # Boolean indicating if the game was completed
  "questions_count": 0,      # Questions attached to this game
  "questions": []            # Questions array, where each object in the array is the question model
}
```

### Question API Model
```
{
  "id": 38,                                       # The id of the question
  "body": "מישהו ממש מעצבן אותך במידברן, אתה:",   # Question's body. For question_type: 'text'
                                                      questions, this will include the text of the question.
                                                      For other types, body is a url for the source
                                                      The be included while presenting the question.
  "question_type": "text",                        # 3 question types: {"text", "image", "video"}
  "level": "easy",                                # Question's level: {"easy", "very_hard"}
  "category_id": 3,                               # Category id of the question, out of 11 categories.
                                                      See app/model/category.rb for full list
  "answers": []                                   # Possible answers for the question
}
```

### Answer API Model
```
{                                                                 
  "id": 149,                    # The id of the answer
  "answer_type": "text",        # 3 answer types: {"text", "image", "video"}
  "body": "דוקר אותו עם נוצה"    # Answer body. Similar to question's body.
}
```

## Burner Games API example

### 1. Start a new game
```bash
curl -X POST http://localhost:3000/api/v1/games/new -d '{"user_id": 22}' --header "Content-Type:application/json"
```

##### Response:
```json
{
  "status": null,
  "token": "N3JU7i",
  "user_id": 22,
  "answered_correctly": 0,
  "questions_count": 0,
  "categories": [
    {
      "name": "communal_effort",
      "corrects": 0
    },
    {
      "name": "gifting",
      "corrects": 0
    },
    {
      "name": "immediacy",
      "corrects": 0
    },
    {
      "name": "radical_self_reliance",
      "corrects": 0
    },
    {
      "name": "radical_self_expression",
      "corrects": 0
    }
  ]
}
```

###### Notice that the game's token is `N3JU7i`, we will need it for all of our future requests

### 2. Get List of Questions
```bash
curl -X GET http://localhost:3000/api/v1/games/N3JU7i/questions --header "Content-Type:application/json"
```

##### Response:
```json
{
  "questions": []
}
```

###### Notice: previous versions of the API returned the game model, but that was removed.

### 3. Add Question To Game: "N3JU7i" with category 'communal_effort' (which is part of this game!)
```bash
curl -X POST http://localhost:3000/api/v1/games/N3JU7i/new_question -d '{"category":"communal_effort"}' --header "Content-Type:application/json"
```

##### Response:
```json
{
  "id": 2,
  "body": "אתה מגיע למידברן ופוגש בחד-קרן צבעוני ביותר שמסביר לך על עקרונות העיר, מחלק לך מפה ותוכניה ומכריח אותך להתפלש בחול בצורת מלאך. הוא כמובן שייך למחלקת _________",
  "question_type": "text",
  "level": "easy",
  "category": {
    "id": 7,
    "name": "communal_effort"
  },
  "answers": [
    {
      "id": 5,
      "answer_type": "text",
      "body": "דייט"
    },
    {
      "id": 6,
      "answer_type": "text",
      "body": "IT"
    },
    {
      "id": 7,
      "answer_type": "text",
      "body": "מפ\"צ"
    },
    {
      "id": 8,
      "answer_type": "text",
      "body": "גריטרז"
    }
  ]
}
```

### 3.1. Add Question To Game: "N3JU7i" with the wrong category.

```bash
curl -X POST http://localhost:3000/api/v1/games/N3JU7i/new_question -d '{"category":"inclusion"}' --header "Content-Type:application/json"
```

```json
{
  "status": "error",
  "message": "this category is not part of this game"
}
```

> The following categories exists:
> "other", "inclusion", "gifting", "decommodification", "radical_self_reliance", "radical_self_expression", "communal_effort", "civic_responsibility", "leaving_no_trace", "participation", "immediacy". For more, see Category model file.

### 4. Listing the Game's questions
```bash
curl -X GET http://localhost:3000/api/v1/games/N3JU7i/questions --header "Content-Type:application/json"
```

##### Response:

```bash
{
  "questions": [
    {
      "id": 2,
      "body": "אתה מגיע למידברן ופוגש בחד-קרן צבעוני ביותר שמסביר לך על עקרונות העיר, מחלק לך מפה ותוכניה ומכריח אותך להתפלש בחול בצורת מלאך. הוא כמובן שייך למחלקת _________",
      "question_type": "text",
      "level": "easy",
      "category": null,
      "answers": [
        {
          "id": 5,
          "answer_type": "text",
          "body": "דייט"
        },
        {
          "id": 6,
          "answer_type": "text",
          "body": "IT"
        },
        {
          "id": 7,
          "answer_type": "text",
          "body": "מפ\"צ"
        },
        {
          "id": 8,
          "answer_type": "text",
          "body": "גריטרז"
        }
      ]
    }
  ]
}
```

### 5. Submitting a WRONG Answer For a Question
```bash
curl -X POST http://localhost:3000/api/v1/games/N3JU7i/answer -d '{"question_id": "2", "answer_ids":["5"]}' --header "Content-Type:application/json"
```

##### Response:
```json
{
  "response": false,
  "category_completed": false,
  "game_completed": false,
  "correct_answers": [
    {
      "id": 8,
      "answer_type": "text",
      "body": "גריטרז"
    }
  ]
}
```

### 6. Submitting a CORRECT Answer For a Question
```bash
curl -X POST http://localhost:3000/api/v1/games/N3JU7i/answer -d '{"question_id": "2", "answer_ids":["8"]}' --header "Content-Type:application/json"
```

##### Response:
```json
{
  "response": true,
  "category_completed": false,
  "game_completed": false
}
```

### 7. Submitting a HINT request For a Question
```bash
curl -X POST http://localhost:3000/api/v1/games/N3JU7i/hint -d '{"question_id": "8"}' --header "Content-Type:application/json"
```

##### Response:
```json
{
  "hints": [
    {
      "id": 32,
      "answer_type": "text",
      "body": "קורא את כל המסמך (בואנה, זה ממש מעניין כל המידברן הזה)"
    },
    {
      "id": 29,
      "answer_type": "text",
      "body": "יאללה, יאללה, אני גבר גבר, לוקח המון בירה (כי זו מסיבה) ויוצא"
    }
  ]
}
```

### 8. Answering a question correctly & user finished category
```bash
curl -X POST http://localhost:3000/api/v1/games/N3JU7i/answer -d '{"question_id": "8", "answer_ids":["32"]}' --header "Content-Type:application/json"
```

```json
{
  "response": true,
  "category_completed": true,
  "game_completed": false
}
```

### 8. Answering a question correctly & user finish **ALL** categories 
```bash
curl -X POST http://localhost:3000/api/v1/games/N3JU7i/answer -d '{"question_id": "8", "answer_ids":["32"]}' --header "Content-Type:application/json"
```

```json
{
  "response": true,
  "category_completed": true,
  "game_completed": true
}
```

