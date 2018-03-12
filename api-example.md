## API REQUEST: /games/new - NEW GAME REQUEST

```
curl -X POST https://production.953caigbma.eu-west-1.elasticbeanstalk.com/api/v1/games/new -d '{"user_id": 22}' --header "Content-Type:application/json"
```

##### Request Params

* `user_id` - the user's id from spark/drupal system. Once the game is over, the games server will perform a private API call to the user managemetn system to mark that the user pass the game.

##### Response

```
{
  "token": "91OC6E",
  "status": null,
  "user_id": 888,
  "answered_correctly": 0,
  "questions_count": 25,
  "completed": false,
  "categories": [
    {
      "category_id": 5,
      "name": "safe_zone",
      "corrects": 0,
      "category_completed": false,
      "questions": [
        {
          "id": 24,
          "body": "הגיפטינג שלך הוא מיכל ריסוס של מים קרים כדי לרענן עוברים ושבים. מסיבת צהריים לוהטת, מישהו יושב בצד ולא לגמרי בעניין המסיבה. מה תעשי?",
          "question_type": "text",
          "level": "easy",
          "category": {
            "id": 5,
            "name": "safe_zone"
          },
          "answers": [
            {
              "id": 96,
              "answer_type": "text",
              "body": "אשאל אותו אם מתאים לו שפריץ ואם כן, מרססת אותו בחדווה וברגישות"
            },
            {
              "id": 93,
              "answer_type": "text",
              "body": "אשפריץ על חברים שלי שרוקדים קרוב ואדאג שיירטב גם, בלי כוונה"
            },
            {
              "id": 94,
              "answer_type": "text",
              "body": "אשאל אותו אם בא לו להרטב ואם הוא אומר כן, אפילו מהוסס, מרוקנת עליו מיכל"
            },
            {
              "id": 95,
              "answer_type": "text",
              "body": "ארסס את האוויר בסביבתו ואתיישב לידו במהירות כדי שנרטב ביחד"
            }
          ]
        },

        // ... MORE QUESTIONS ...

      ]
    },
    {
      "category_id": 4,
      "name": "leave_no_trace",
      "corrects": 0,
      "category_completed": false,
      "questions": [
        {
          "id": 3,
          "body": "אני מת להשתין. מת! מה עושים? ",
          "question_type": "text",
          "level": "easy",
          "category": {
            "id": 4,
            "name": "leave_no_trace"
          },
          "answers": [
            {
              "id": 12,
              "answer_type": "text",
              "body": "הולכים לשירותים כימיים שמידברן מספקים"
            },
            {
              "id": 10,
              "answer_type": "text",
              "body": "לך לבריכת האידוי של השכן, איש לא ישים לב"
            },
            {
              "id": 9,
              "answer_type": "text",
              "body": "תשתין בכל מקום, זה מדבר"
            },
            {
              "id": 11,
              "answer_type": "text",
              "body": "רק בחניון מותר"
            }
          ]
        },


        // ... MORE QUESTIONS ...

      ]
    },


    // ... MORE CATEGORIES + THEIR QUESTIONS ...


  ]
}
```

##### Response Params

* `token` - is a 6 characters unique id of a game (for example: `91OC6E`)
* `status` - deprecated. In the pass we thought a user will be able to continue an old game, but we decided it no longer relevant.
* `user_id` - the playing user's id.
* `answered_correctly` - the amount of questions the user answered correctly.
* `questions_count` - amount of questions in the game.
* `completed` - is the game completed or no
* `categories` - the categories (defaults to 5) and their questions in the game.

## API REQUEST: /games/:token/answer - ANSWERING A QUESTION INCORRECTLY

```
curl 'http://production.953caigbma.eu-west-1.elasticbeanstalk.com/api/v1/games/91OC6E/answer' --header 'Content-Type: application/json' -d '{"question_id":"22","answer_ids":["86"]}'
```

##### Request Params

* `question_id` - the id of the question.
* `answer_ids` - an array of correct answers ids.

> Notes:
> Game token: Please notice that the game's token is on the url, user can not answer a question that do not belong to the game.
> Answer ids must belong to the question.

##### Response

```
{
  "response": false,
  "category_completed": false,
  "game_completed": false,
  "correct_answers": [
    {
      "id": 88,
      "answer_type": "text",
      "body": "אגש ואשאל אם היא מודעת למה שקורה, אם כן - אניח להם, ואם איני בטוח, אגייס עזרה "
    }
  ]
}
```

##### Response Params

* `response` - Did the user answer the question correctly or incorrectly.
* `category_completed` - Did the user answered enough question in the category to move forward to the next category
* `game_completed` - Did the user completed the game or there are more questions to be answer.
* `correct_answers` - an array of the correct answers of the question.


## API REQUEST: /games/:token/answer - ANSWERING A QUESTION CORRECTLY 

```
curl 'http://production.953caigbma.eu-west-1.elasticbeanstalk.com/api/v1/games/91OC6E/answer' --header 'Content-Type: application/json' -d '{"question_id":"22","answer_ids":["88"]}'
```

##### Request Params

* `question_id` - the id of the question.
* `answer_ids` - an array of correct answers ids.

> Notes:
> Game token: Please notice that the game's token is on the url, user can not answer a question that do not belong to the game.
> Answer ids must belong to the question.

##### Response

```
{
  "response": true,
  "category_completed": false,
  "game_completed": false
}
```

##### Response Params

* `response` - Did the user answer the question correctly or incorrectly.
* `category_completed` - Did the user answered enough question in the category to move forward to the next category
* `game_completed` - Did the user completed the game or there are more questions to be answer.


## GOOD LUCK