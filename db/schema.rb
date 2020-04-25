# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_25_133534) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercise_reports", force: :cascade do |t|
    t.bigint "workout_report_id", null: false
    t.float "weight"
    t.bigint "workout_exercise_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["workout_exercise_id"], name: "index_exercise_reports_on_workout_exercise_id"
    t.index ["workout_report_id"], name: "index_exercise_reports_on_workout_report_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "training_routines", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "started_at"
    t.date "finished_at"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_training_routines_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "kind"
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workout_exercises", force: :cascade do |t|
    t.bigint "exercise_id", null: false
    t.bigint "workout_id", null: false
    t.integer "repetitions"
    t.integer "rest_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exercise_id"], name: "index_workout_exercises_on_exercise_id"
    t.index ["workout_id"], name: "index_workout_exercises_on_workout_id"
  end

  create_table "workout_reports", force: :cascade do |t|
    t.bigint "workout_id", null: false
    t.date "date"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["workout_id"], name: "index_workout_reports_on_workout_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.bigint "training_routine_id", null: false
    t.string "name"
    t.integer "classes_to_attend"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["training_routine_id"], name: "index_workouts_on_training_routine_id"
  end

  add_foreign_key "exercise_reports", "workout_exercises"
  add_foreign_key "exercise_reports", "workout_reports"
  add_foreign_key "training_routines", "users"
  add_foreign_key "workout_exercises", "exercises"
  add_foreign_key "workout_exercises", "workouts"
  add_foreign_key "workout_reports", "workouts"
  add_foreign_key "workouts", "training_routines"
end
