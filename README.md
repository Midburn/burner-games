# The Burner Games

Burner games is a simple trivia game developed by the midburn.org organization volunteers as an educational step for the [Midburn organization](http://midburn.org) ticketing system. While playing the game, the participants will be questioned about [Midburn 10 principeles](http://midburn.org/en-ten-principles/) which are the primary guidance of the Midburn Organization.

- **Primary Goal**: Educate the Midburn events participants about the 10 principles, the events' vibe and explain the participants' behavior in a simple, fun & humoristic way.
- Secondary Goal: Ensure that participants who buy tickets have done the effort to educate themselves, and get the right "mix" of people admitted.
- Tertiary Goal: Prevent bots from automatically purchasing many tickets for scalping purposes.

## Product: Games Rules

1. Each midburn profile will get a link to the game upon getting the mail with their purchased midburn ticket.
1. In order to win, participants will have to pass 5 different topics (="categories"), selected per game randomly out of 10+ possible options.
2. Passing a topic means answering 2 consecutive questions correctly, from a pool of 5-10 questions per topic.
3. As long as there aren't 2 consecutive correct answers, topic's questions continue to cycle (order of questions in the cycle is determined per game randomly).
1. Wrong answers will show the participant the correct answer before moving to the next question.
1. All questions will have the same difficulty level.
1. There are two "life lines" available for single use per topic. Each one is not available any more once used, but when passing to the next topic, both are available again.
2. First life line allows to skip a question without losing the "correct answer streak".
3. Second life line eliminates two out of four answers (the two must be false answers).
1. A permanent link on the user interface will refer to midburn.org website for additional reading.

#### Questions
There are 3 types of questions: text, image and video questions. There are 11 questions categories and questions level is a number between 0 to 100 where 0 is the easy and 100 is hardest possible question. For more info, see Question model.

**For the scope of first public version (May 2016) we will implement in the front end only text and image questions, without different difficulties**

#### Answers
Similarly to questions, answers can be text, images or video answers. There are no limits for the amount of answers in a question or the amount of correct answers. There are no "half correct" questions, for example: if a question consist of 4 answers, among these 2 are correct, the only *"right"* way to answer the question will be selecting both answers. For more info, see Answer model.

**For the scope of first public version (May 2016) we will implement in the front end only text answers, and a single correct answer to eacha question**

## Visual Indications in the front end
1. Correct answer popup/resonse
2. Wrong answer popup/resonse (acknowleging what the correct answer was)
3. Progression through game (burning man graphic on the left, animated, marking current topic, including topics names)
4. Progression trhough topic (UI element indicating how many more correct answers are needed to pass)
5. Life lines (available/unavailable)

## Development Guidance (for all levels)

This application is developed as part of the Midburn platform, therefore it was designed as an API first.
> Find a full API documentation / examples on `api-example.md`

`burner-games` is deployed on `https://burner-games.herokuapp.com` for development purposes. If you're less experienced with running Ruby on Rails services & you work on the front-end side, you may use the heroku.com dev environment as your back-end service.

If you're still want to run the service locally, follow the following configs:

- Ruby: `ruby-2.1.7`
- System dependencies: `MySQL`
- Environment configuration: See `.env-example` file for local environment configuration
- Database creation: See `config/database.yml` for additional info.
- Database initialization: run `bin/rake midburn:seed_data`
- How to run the test suite: `bin/rspec`
> Side note: Since this project is intended to be developed over a weekend hackathon, tests are currently not supported

- Services: `heroku`. Please contact `@elad_g` for credentials.
- Deployment instructions: `git push heroku master`

##### Technical Guidance

- There is nothing specific about this application. It's a regular Ruby on Rails application (and PLEASE lets keep it this way :+1:)
- No method should be longer then 8 lines of code.
- Keep controller space clean and easy to read.
- Refactor code repeats into concerns or service classes. Remember, less code, less bugs!

## Contributing Guidance

Thank you for your interest in contributing, you are awesome!!!! yet in order to optimizes everyone's time, please follow the following:

- Please keep `master` branch clean of work in progress / half implemented features or broken versions. Bugs are fine :wink:

- Each feature should be branched out of master and be merge with a pull request. Even if you're reviewing your own work (because no-one else is around to help :forever-alone:), please submit a pull request as it's easier to review then a mixed set of commits stream from different developers.

- Follow git-flow spec for correct use of git in this repo. If you are not sure about something, ask (open a ticket). If you can't wait for an answer, fork the repo, commit and continue working on the forked version. You will still be able to submit pull request to the original repo! :+1: :+1:

### API Spec

Please follow: api-spec.md document.

### Technical Design

Please see technical-design.md document.

### LICENSE

See LICENSE file included in this repository.

### QA
If you want to help us QA this game, check out the [test instance](https://s3-eu-west-1.amazonaws.com/burner-games-frontend/index.html?userId=11#), and report issues on this repository (backened) or on the [frontend repo](https://github.com/Midburn/Midburn-Quiz-Frontend).
