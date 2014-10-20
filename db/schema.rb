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

ActiveRecord::Schema.define(version: 20140921174800) do

  create_table "disponibilites", force: true do |t|
    t.integer  "utilisateur_absent_id"
    t.integer  "utilisateur_remplacant_id"
    t.integer  "endroit_id"
    t.integer  "niveau_id"
    t.datetime "date_heure_debut"
    t.datetime "date_heure_fin"
    t.boolean  "surveillance"
    t.boolean  "specialite"
    t.text     "notes"
    t.string   "statut"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "endroits", force: true do |t|
    t.string   "nom"
    t.string   "adresse"
    t.string   "numero_telephone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "niveaus", force: true do |t|
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "code"
  end

  create_table "remplacements", force: true do |t|
    t.integer  "id_utilisateur"
    t.string   "id_event_calendar"
    t.integer  "id_utilisateur_remplacant"
    t.string   "statut"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "utilisateurs", force: true do |t|
    t.string   "nom"
    t.string   "prenom"
    t.string   "courriel"
    t.string   "titre"
    t.string   "numero_telephone"
    t.string   "numero_cellulaire"
    t.boolean  "message_texte_permis"
    t.integer  "niveau"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
