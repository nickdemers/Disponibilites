class RenameRolesUtilisateursToRolesUsers < ActiveRecord::Migration
  def change
    rename_table :roles_utilisateurs, :roles_users
  end
end
