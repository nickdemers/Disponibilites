class CreateUtilisateurs < ActiveRecord::Migration
  def change
    create_table :utilisateurs do |t|
      t.string :nom
      t.string :prenom
      t.string :courriel
      t.string :titre
      t.string :numero_telephone
      t.string :numero_cellulaire
      t.boolean :message_texte_permis
      t.integer :niveau

      t.timestamps
    end
  end
end
