# The Burner Games

Burner games is a simple API based trivia game develop by the midburn.org organization volunteers as an educational step for the Midburn organization ticketing system. While playing the game, the participates will be questioned about Burning Man 10 principeles which are the main guidance of the Midburn Organization.

To read more about Midburn organization, see: http://midburn.org

Main Goal: Educate the Midburn events participants about the 10 participates, the event's vibe, participates' expected behavior in a simple, fun & humoristic way.

## Product: Games Rules

1. Each midburn profile will have to pass the trivia before purchasing a midburn event ticket or while transferring the ticket to a different profile (with the exception of manual admin intervention).
1. Participants will be presented with 10 questions.
1. The questions will be in different levels. The initial 3 questions will be easy questions.
1. Questions are skippable.
1. While playing, wrong answers will show the participant the correct answer and will move forward.
1. While playing, a link on the user interface will refer to midburn.org website for additional reading.

##### Questions
There are 3 types of questions: text, image and video questions. There are 11 questions categories and questions level is a number between 0 to 100 where 0 is the easy and 100 is hardest possible question. For more info, see Question model.

##### Answers
Similarly to questions, answers can be text, images or video answers. There is no limits for the amount of answers in a question or the amount of correct answers. Although, there are no half correct questions, for example: if a question consist of 4 answers, among these 2 are correct, the only *"right"* way to answer the question will be selecting both answers. For more info, see Answer model.

## Development Guidance (for all levels)

This repo (or application) was developed as part of the Midburn platform, therefor it was designed as an API first.
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
