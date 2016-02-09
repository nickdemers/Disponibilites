class RenameColumnUtilisateurToUser < ActiveRecord::Migration
  def change
    #rename_column :roles_users, :utilisateur_id, :user_id
    rename_column :disponibilites, :utilisateur_absent_id, :user_absent_id
    rename_column :disponibilites, :utilisateur_remplacant_id, :user_remplacant_id
  end
end
