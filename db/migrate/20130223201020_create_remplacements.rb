class CreateRemplacements < ActiveRecord::Migration
  def change
    create_table :remplacements do |t|
      t.integer :id_utilisateur
      t.string :id_event_calendar
      t.integer :id_utilisateur_remplacant
      t.string :statut

      t.timestamps
    end
  end
end
