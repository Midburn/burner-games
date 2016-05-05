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

ActiveRecord::Schema.define(version: 20160505132359) do

  create_table "answers", force: :cascade do |t|
    t.integer  "answer_type", limit: 4,   default: 0, null: false
    t.string   "body",        limit: 255,             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "categories_games", force: :cascade do |t|
    t.integer "category_id", limit: 4
    t.integer "game_id",     limit: 4
    t.integer "corrects",    limit: 4, default: 0
  end

  add_index "categories_games", ["category_id"], name: "index_categories_games_on_category_id", using: :btree
  add_index "categories_games", ["game_id"], name: "index_categories_games_on_game_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.string   "token",      limit: 255
    t.string   "status",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    limit: 4,   null: false
  end

  create_table "games_questions", id: false, force: :cascade do |t|
    t.integer  "game_id",     limit: 4
    t.integer  "question_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games_questions", ["game_id", "question_id"], name: "index_games_questions_on_game_id_and_question_id", unique: true, using: :btree
  add_index "games_questions", ["game_id"], name: "index_games_questions_on_game_id", using: :btree
  add_index "games_questions", ["question_id"], name: "index_games_questions_on_question_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "body",          limit: 255,             null: false
    t.integer  "question_type", limit: 4,   default: 0, null: false
    t.integer  "level",         limit: 4,   default: 0
    t.integer  "category_id",   limit: 4,   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "token",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_answers", force: :cascade do |t|
    t.integer "question_id", limit: 4
    t.integer "answer_id",   limit: 4
    t.boolean "correct",               default: false, null: false
  end

  add_index "user_answers", ["answer_id"], name: "index_user_answers_on_answer_id", using: :btree
  add_index "user_answers", ["question_id"], name: "index_user_answers_on_question_id", using: :btree

end
