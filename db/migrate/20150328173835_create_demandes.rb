class CreateDemandes < ActiveRecord::Migration
  def change
    create_table :demandes do |t|
      t.references :user, index: true
      t.references :disponibilite, index: true
      t.integer :priority
      t.string :status

      t.timestamps null: false
    end
    add_foreign_key :demandes, :users
    add_foreign_key :demandes, :disponibilites
  end
end
