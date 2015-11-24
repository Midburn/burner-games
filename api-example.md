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

###### Notice :!: game token: `xfu6Zy`

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
}```

###### Notice game question list is empty.

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
