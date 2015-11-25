# API Examples

## Models

### Game API Model
```
{
  "token": "t0k3n",          # The game's uniqe identifyer
  "status": null,            # Status of the game: {started, ended, expired}
  "user_id": 22,             # The midburn profile user id
  "answered_correctly": 0,   # Questions that were answered correctly during this game
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
  "category": null,                               # Category of the question, out of 11 categories.
                                                      See app/model/question.rb for full list
  "answers": []                                   # Possible answers for the question
}
```

### Question API Model
```
{                                                                 
  "id": 149,                    # The id of the answer
  "answer_type": "text",        # 3 answer types: {"text", "image", "video"}
  "body": "דוקר אותו עם נוצה"    # Answer body. Simular to question's body.
}
```

## Burner Games API example

### 1. Start a new game
```bash
curl -X POST http://localhost:3000/api/v1/games/new -d '{"user_id": 22}' --header "Content-Type:application/json"
```

##### Response:
```bash
{
  "status": null,
  "token": "xfu6Zy",
  "user_id": 22,
  "answered_correctly": 0,
  "questions_count": 0
}
```

###### Notice that the game's token is `xfu6Zy`, we will need it for all of our future requests

### 2. Get List of Questions
```bash
curl -X GET http://localhost:3000/api/v1/games/xfu6Zy/questions -d '{}' --header "Content-Type:application/json"
```

##### Response:
```bash
{
  "game": {
    "token": "xfu6Zy",
    "status": null,
    "user_id": 22,
    "answered_correctly": 0,
    "questions_count": 0,
    "questions": []
  }
}
```

###### Notice game questions list is empty.

### 3. Add Question To Game: "xfu6Zy"
```bash
curl -X POST http://localhost:3000/api/v1/games/xfu6Zy/new_question -d '{}' --header "Content-Type:application/json"
```

##### Response:
```bash
{
  "id": 38,
  "body": "מישהו ממש מעצבן אותי במידברן, אתה:",
  "question_type": "text",
  "level": "easy",
  "category": null,
  "answers": [
    {
      "id": 149,
      "answer_type": "text",
      "body": "דוקר אותו (עם נוצה), נראה לו שהוא יעקוף אותי בתור לקרח?!"
    },
    {
      "id": 150,
      "answer_type": "text",
      "body": "מזמין עליו משטרה, נראה לו שהוא יסתכל עליי ככה?!"
    },
    {
      "id": 151,
      "answer_type": "text",
      "body": "מתחיל לקלל, יורק, אוסף סביבי כל מיני אנשים שיעצרו אותי, למה אני אכנס בו!"
    },
    {
      "id": 152,
      "answer_type": "text",
      "body": "נרגע. סופר על 10. חושב אם זה חלק מההבעה עצמית הרדיקלית שלו. אם הוא חורג, מוצא נווד חביב שיעזור לגשר."
    }
  ]
}
```

###### The question model is been sent back on the `new_question` api request.

### 4. Listing the Game's questions
```bash
curl -X GET http://localhost:3000/api/v1/games/xfu6Zy/questions -d '{}' --header "Content-Type:application/json"
```

##### Response:

```bash
{
  "game": {
    "token": "xfu6Zy",
    "status": null,
    "user_id": 22,
    "answered_correctly": 0,
    "questions_count": 1,
    "questions": [
      {
        "id": 38,
        "body": "מישהו ממש מעצבן אותי במידברן, אתה:",
        "question_type": "text",
        "level": "easy",
        "category": null,
        "answers": [
          {
            "id": 149,
            "answer_type": "text",
            "body": "דוקר אותו (עם נוצה), נראה לו שהוא יעקוף אותי בתור לקרח?!"
          },
          {
            "id": 150,
            "answer_type": "text",
            "body": "מזמין עליו משטרה, נראה לו שהוא יסתכל עליי ככה?!"
          },
          {
            "id": 151,
            "answer_type": "text",
            "body": "מתחיל לקלל, יורק, אוסף סביבי כל מיני אנשים שיעצרו אותי, למה אני אכנס בו!"
          },
          {
            "id": 152,
            "answer_type": "text",
            "body": "נרגע. סופר על 10. חושב אם זה חלק מההבעה עצמית הרדיקלית שלו. אם הוא חורג, מוצא נווד חביב שיעזור לגשר."
          }
        ]
      }
    ]
  }
}
```

### 5. Submitting a WRONG Answer For a Question
```bash
curl -X POST http://localhost:3000/api/v1/games/xfu6Zy/answer -d '{"question_id": "38", "answer_ids":["151"]}' --header "Content-Type:application/json"
```

##### Response:
```bash
{
  "response": "wrong",
  "game": {
    "token": "xfu6Zy",
    "status": null,
    "user_id": 22,
    "answered_correctly": 0,
    "questions_count": 1
  }
}
```

### 6. Submitting a WRONG Multiple Choice Answer
```bash
curl -X POST http://localhost:3000/api/v1/games/xfu6Zy/answer -d '{"question_id": "38", "answer_ids":["151,152"]}' --header "Content-Type:application/json"
```

##### Response:
```bash
{
  "response": "wrong",
  "game": {
    "token": "xfu6Zy",
    "status": null,
    "user_id": 22,
    "answered_correctly": 0,
    "questions_count": 1
  }
}
```

### 7. Submitting a CORRECT Answer For a Question
```bash
curl -X POST http://localhost:3000/api/v1/games/xfu6Zy/answer -d '{"question_id": "38", "answer_ids":["152"]}' --header "Content-Type:application/json"
```

##### Response:
```bash
{
  "response": "correct",
  "game": {
    "token": "xfu6Zy",
    "status": null,
    "user_id": 22,
    "answered_correctly": 1,
    "questions_count": 1
  }
}
```

### 8. Submitting a CORRECT Multiple Choice Answer
```bash
curl -X POST http://localhost:3000/api/v1/games/xfu6Zy/answer -d '{"question_id": "38", "answer_ids":["152,153"]}' --header "Content-Type:application/json"
```

##### Response:
```bash
{
  "response": "correct",
  "game": {
    "token": "xfu6Zy",
    "status": null,
    "user_id": 22,
    "answered_correctly": 1,
    "questions_count": 1
  }
}
```
