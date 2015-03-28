class CreateRolesUtilisateurs < ActiveRecord::Migration
  def self.up
    create_table :roles_utilisateurs, :id => false do |t|
      t.references :role, :user
    end
  end

  def self.down
    drop_table :roles_utilisateurs
  end
end