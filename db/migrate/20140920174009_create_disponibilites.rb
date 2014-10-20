class CreateDisponibilites < ActiveRecord::Migration
  def change
    create_table :disponibilites do |t|
      t.integer :utilisateur_absent_id
      t.integer :utilisateur_remplacant_id
      t.integer :endroit_id
      t.integer :niveau_id
      t.datetime :date_heure_debut
      t.datetime :date_heure_fin
      t.boolean :surveillance
      t.boolean :specialite
      t.text :notes
      t.string :statut
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
