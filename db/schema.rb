# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151124004702) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer  "answer_type", default: 0, null: false
    t.string   "body",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: :cascade do |t|
    t.string   "token"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                        null: false
    t.integer  "answered_correctly", default: 0, null: false
  end

  create_table "games_questions", id: false, force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games_questions", ["game_id", "question_id"], name: "index_games_questions_on_game_id_and_question_id", unique: true, using: :btree
  add_index "games_questions", ["game_id"], name: "index_games_questions_on_game_id", using: :btree
  add_index "games_questions", ["question_id"], name: "index_games_questions_on_question_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "body",                        null: false
    t.integer  "question_type", default: 0,   null: false
    t.integer  "level",         default: 0
    t.string   "category",      default: "0"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_answers", force: :cascade do |t|
    t.integer "question_id"
    t.integer "answer_id"
    t.boolean "correct",     default: false, null: false
  end

  add_index "user_answers", ["answer_id"], name: "index_user_answers_on_answer_id", using: :btree
  add_index "user_answers", ["question_id"], name: "index_user_answers_on_question_id", using: :btree

end
