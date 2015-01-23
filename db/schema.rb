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

ActiveRecord::Schema.define(version: 20150120005904) do

  create_table "disponibilites", force: :cascade do |t|
    t.integer  "utilisateur_absent_id",     limit: 4
    t.integer  "utilisateur_remplacant_id", limit: 4
    t.integer  "niveau_id",                 limit: 4
    t.datetime "date_heure_debut"
    t.datetime "date_heure_fin"
    t.boolean  "surveillance",              limit: 1
    t.boolean  "specialite",                limit: 1
    t.text     "notes",                     limit: 65535
    t.string   "statut",                    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ecole_id",                  limit: 4
  end

  add_index "disponibilites", ["ecole_id"], name: "index_disponibilites_on_ecole_id", using: :btree

  create_table "ecoles", force: :cascade do |t|
    t.string   "nom",              limit: 255
    t.string   "adresse",          limit: 255
    t.string   "numero_telephone", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "nom",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_utilisateurs", id: false, force: :cascade do |t|
    t.integer "role_id",        limit: 4
    t.integer "utilisateur_id", limit: 4
  end

  create_table "utilisateurs", force: :cascade do |t|
    t.string   "nom",                    limit: 255
    t.string   "prenom",                 limit: 255
    t.string   "courriel",               limit: 255
    t.string   "titre",                  limit: 255
    t.string   "numero_telephone",       limit: 255
    t.string   "numero_cellulaire",      limit: 255
    t.boolean  "message_texte_permis",   limit: 1
    t.integer  "niveau",                 limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 4,  null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
  end

  add_index "utilisateurs", ["email"], name: "index_utilisateurs_on_email", unique: true, using: :btree
  add_index "utilisateurs", ["reset_password_token"], name: "index_utilisateurs_on_reset_password_token", unique: true, using: :btree
  add_index "utilisateurs", ["unlock_token"], name: "index_utilisateurs_on_unlock_token", unique: true, using: :btree

  add_foreign_key "disponibilites", "ecoles"
end
