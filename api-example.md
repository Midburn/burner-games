# API Examples

## Models

### Game API Model
```
{
  "token": "t0k3n",          # The game's unique identifier
  "status": null,            # Status of the game: {started, ended, expired}
  "user_id": 22,             # The Midburn profile user id
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
```bash
{
  "status": null,
  "token": "JB1wRZ",
  "user_id": 22,
  "answered_correctly": 0,
  "questions_count": 0,
  "categories": [
    "communal_effort",
    "radical_self_expression",
    "inclusion",
    "gifting",
    "civic_responsibility"
  ]
}
```

###### Notice that the game's token is `JB1wRZ`, we will need it for all of our future requests

### 2. Get List of Questions
```bash
curl -X GET http://localhost:3000/api/v1/games/JB1wRZ/questions -d '{}' --header "Content-Type:application/json"
```

##### Response:
```bash
{
  "game": {
    "token": "JB1wRZ",
    "status": null,
    "user_id": 22,
    "answered_correctly": 0,
    "questions_count": 0,
    "categories": [
      "communal_effort",
      "radical_self_expression",
      "inclusion",
      "gifting",
      "civic_responsibility"
    ],
    "questions": []
  }
}
```

###### Notice game questions list is empty.

### 3. Add Question To Game: "JB1wRZ" with category 'inclusion' (for list of categories see below)
```bash
curl -X POST http://localhost:3000/api/v1/games/JB1wRZ/new_question -d '{"category":"inclusion"}' --header "Content-Type:application/json"
```

##### Response:
```bash
{
  "id": 15,
  "body": "הוזמנת למסיבה ברנרית מגניבה! ועוד בחינם! אתה...",
  "question_type": "text",
  "level": "easy",
  "category": "other",
  "answers": [
    {
      "id": 57,
      "answer_type": "text",
      "body": "שמח שסוף סוף יש מסיבה שלא צריך לשלם עליה בכניסה, כי בדיוק סגרת חודשיים אבטלה, והולך אליה בכיסים ריקים ובלב מלא."
    },
    {
      "id": 58,
      "answer_type": "text",
      "body": "מביא איתי כסף רק לבירה שאי אקנה (לעצמי) שם, ומשתדל שלא לשאול שאלות קיטבג כמו \"צריך עזרה?\"..."
    },
    {
      "id": 59,
      "answer_type": "text",
      "body": "בא עם כל החבר'ה שלי, עושים שמח ובלגן, ואז מתחפפים לפי שצריך לנקות..."
    },
    {
      "id": 60,
      "answer_type": "text",
      "body": "שואל אם צריך להביא מישהו, או מביא אלכוהול לשתייה של המסיבה, ובכל מקרה נשאר בסוף לעזור לחשלש!"
    }
  ]
}
```

### 3.1. Add Question To Game: "JB1wRZ" with the wrong category.

curl -X POST http://localhost:3000/api/v1/games/JB1wRZ/new_question -d '{"category":"decommodification"}' --header "Content-Type:application/json"

```bash
{
  "status": "error",
  "message": "this category is not part of this game"
}
```

> The following categories exists on the db: 
> "other", "inclusion", "gifting", "decommodification", "radical_self_reliance", "radical_self_expression", "communal_effort", "civic_responsibility", "leaving_no_trace", "participation", "immediacy". For more, see Question model file.

###### The question model is been sent back on the `new_question` api request.

### 4. Listing the Game's questions
```bash
curl -X GET http://localhost:3000/api/v1/games/JB1wRZ/questions -d '{}' --header "Content-Type:application/json"
```

##### Response:

```bash
{
  "game": {
    "token": "JB1wRZ",
    "status": null,
    "user_id": 22,
    "answered_correctly": 0,
    "questions_count": 1,
    "categories": [
      "communal_effort",
      "radical_self_expression",
      "inclusion",
      "gifting",
      "civic_responsibility"
    ],
    "questions": [
      {
        "id": 15,
        "body": "הוזמנת למסיבה ברנרית מגניבה! ועוד בחינם! אתה...",
        "question_type": "text",
        "level": "easy",
        "category": "other",
        "answers": [
          {
            "id": 57,
            "answer_type": "text",
            "body": "שמח שסוף סוף יש מסיבה שלא צריך לשלם עליה בכניסה, כי בדיוק סגרת חודשיים אבטלה, והולך אליה בכיסים ריקים ובלב מלא."
          },
          {
            "id": 58,
            "answer_type": "text",
            "body": "מביא איתי כסף רק לבירה שאי אקנה (לעצמי) שם, ומשתדל שלא לשאול שאלות קיטבג כמו \"צריך עזרה?\"..."
          },
          {
            "id": 59,
            "answer_type": "text",
            "body": "בא עם כל החבר'ה שלי, עושים שמח ובלגן, ואז מתחפפים לפי שצריך לנקות..."
          },
          {
            "id": 60,
            "answer_type": "text",
            "body": "שואל אם צריך להביא מישהו, או מביא אלכוהול לשתייה של המסיבה, ובכל מקרה נשאר בסוף לעזור לחשלש!"
          }
        ]
      }
    ]
  }
}
```

### 5. Submitting a WRONG Answer For a Question
```bash
curl -X POST http://localhost:3000/api/v1/games/JB1wRZ/answer -d '{"question_id": "15", "answer_ids":["57"]}' --header "Content-Type:application/json"
```

##### Response:
```bash
{
  "response": "wrong",
  "correct_answers": [
    {
      "id": 60,
      "answer_type": "text",
      "body": "שואל אם צריך להביא מישהו, או מביא אלכוהול לשתייה של המסיבה, ובכל מקרה נשאר בסוף לעזור לחשלש!"
    }
  ]
}
```

### 6. Submitting a WRONG Multiple Choice Answer
```bash
curl -X POST http://localhost:3000/api/v1/games/JB1wRZ/answer -d '{"question_id": "15", "answer_ids":["57,58"]}' --header "Content-Type:application/json"
```

##### Response:
```bash
{
  "response": "wrong",
  "game": {
    "token": "JB1wRZ",
    "status": null,
    "user_id": 22,
    "answered_correctly": 0,
    "questions_count": 1,
    "categories": [
      "communal_effort",
      "radical_self_expression",
      "inclusion",
      "gifting",
      "civic_responsibility"
    ]
  }
}
```

### 7. Submitting a CORRECT Answer For a Question
```bash
curl -X POST http://localhost:3000/api/v1/games/JB1wRZ/answer -d '{"question_id": "15", "answer_ids":["60"]}' --header "Content-Type:application/json"
```

##### Response:
```bash
{
  "response": "correct",
  "game": {
    "token": "JB1wRZ",
    "status": null,
    "user_id": 22,
    "answered_correctly": 2,
    "questions_count": 1,
    "categories": [
      "communal_effort",
      "radical_self_expression",
      "inclusion",
      "gifting",
      "civic_responsibility"
    ]
  }
}
```

### 8. Submitting a HINT request For a Question
```bash
curl -X POST http://localhost:3000/api/v1/games/JB1wRZ/hint -d '{"question_id": "15"}' --header "Content-Type:application/json"
```

##### Response:
```bash
{
  "hints": [
    {
      "id": 60,
      "answer_type": "text",
      "body": "שואל אם צריך להביא מישהו, או מביא אלכוהול לשתייה של המסיבה, ובכל מקרה נשאר בסוף לעזור לחשלש!"
    },
    {
      "id": 57,
      "answer_type": "text",
      "body": "שמח שסוף סוף יש מסיבה שלא צריך לשלם עליה בכניסה, כי בדיוק סגרת חודשיים אבטלה, והולך אליה בכיסים ריקים ובלב מלא."
    }
  ]
}
```

### 9. Submitting a CORRECT Multiple Choice Answer
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
