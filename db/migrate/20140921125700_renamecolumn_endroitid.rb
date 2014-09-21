class RenamecolumnEndroitid < ActiveRecord::Migration
  def change
    rename_column :disponibilites, :lieu_id, :endroit_id
  end
end