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

ActiveRecord::Schema.define(version: 2019_05_16_063534) do

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email"
    t.string "first"
    t.string "last"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "historical_quotes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "symbol"
    t.date "quote_date"
    t.decimal "open", precision: 10
    t.decimal "high_sub_low", precision: 10
    t.decimal "close", precision: 10
    t.decimal "change_percent", precision: 10
    t.decimal "change_over_time", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "predictions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "symbol"
    t.decimal "prediction_open", precision: 10
    t.decimal "prediction_close", precision: 10
    t.decimal "prediction_trend", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "question"
    t.text "content"
    t.integer "num_responses"
    t.decimal "answer_totals", precision: 10
    t.decimal "avg_answer", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link"
    t.string "symb"
  end

  create_table "ticker_symbols", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "symb"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "exchange"
    t.string "industry"
    t.string "sector"
    t.index ["symb"], name: "index_ticker_symbols_on_symb"
  end

end
