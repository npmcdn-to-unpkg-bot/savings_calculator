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

ActiveRecord::Schema.define(version: 20160630222246) do

  create_table "entries", force: :cascade do |t|
    t.integer  "monthly_energy_usage"
    t.integer  "zip"
    t.string   "provider"
    t.string   "subregion"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "fuel_type"
    t.float    "fuel_usage"
  end

  create_table "fuel_costs", force: :cascade do |t|
    t.string   "fuel_type"
    t.float    "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "emissions"
    t.float    "conversion"
  end

  create_table "heating_emissions", force: :cascade do |t|
    t.string   "source"
    t.float    "emissions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rate_providers", force: :cascade do |t|
    t.integer  "zip"
    t.string   "provider"
    t.float    "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subregion_emissions", force: :cascade do |t|
    t.string   "name"
    t.string   "acronym"
    t.float    "emissions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "zip_subregions", force: :cascade do |t|
    t.integer  "zip"
    t.string   "primary_sub"
    t.string   "secondary_sub"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
