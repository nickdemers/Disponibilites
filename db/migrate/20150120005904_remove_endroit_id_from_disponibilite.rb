class RemoveEndroitIdFromDisponibilite < ActiveRecord::Migration
  def change
    remove_column :disponibilites, :endroit_id, :integer
  end
end
