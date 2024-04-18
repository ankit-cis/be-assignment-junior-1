# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_240_418_092_240) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'bills', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.integer 'amount'
    t.bigint 'expense_id', null: false
    t.boolean 'paid', default: false
    t.integer 'pay_to'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'amount_paid'
    t.index ['expense_id'], name: 'index_bills_on_expense_id'
    t.index ['user_id'], name: 'index_bills_on_user_id'
  end

  create_table 'expenses', force: :cascade do |t|
    t.integer 'amount'
    t.string 'description'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'created_by'
  end

  create_table 'expenses_users', force: :cascade do |t|
    t.bigint 'expense_id', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['expense_id'], name: 'index_expenses_users_on_expense_id'
    t.index ['user_id'], name: 'index_expenses_users_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'name'
    t.string 'mobile_number'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'bills', 'expenses'
  add_foreign_key 'bills', 'users'
  add_foreign_key 'expenses_users', 'expenses'
  add_foreign_key 'expenses_users', 'users'
end
