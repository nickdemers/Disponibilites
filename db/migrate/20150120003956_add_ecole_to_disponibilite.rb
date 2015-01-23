class AddEcoleToDisponibilite < ActiveRecord::Migration
  def change
    add_reference :disponibilites, :ecole, index: true
    add_foreign_key :disponibilites, :ecoles
  end
end
