#encoding=utf-8
require 'spec_helper'

describe Role do
  describe "Création" do
    it "avec succès" do
      expect(FactoryGirl.create(:role)).to be_valid
    end

    it "avec succès avec utilisateur" do
      utilisateur = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', message_texte_permis: 'non', niveau: 3, email: 'test@test.ca',
                                        numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent', password: '12345678'})
      role = Role.create({nom: 'admin', utilisateurs: [utilisateur]})
      role.should be_valid
    end

    it "en erreur, doit contenir un nom" do
      Role.create({}).errors.messages.should == {:nom => ["doit être rempli(e)"]}
    end

    it "en erreur, nom contient trop de caractères" do
      Role.create({:nom => "NicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolas"}).errors.messages.should == {:nom => ["est trop long (pas plus de 255 caractères)"]}
    end
  end

  describe "Mise à jour" do
    before(:each) do
      @role = Role.create({nom: 'admin'})
    end
    it "avec succès" do
      @role.nom = 'roleadmin'
      @role.should be_valid
    end

    it "en erreur, doit contenir un nom" do
      @role.nom = nil
      @role.should be_invalid
      @role.errors.messages.should == {:nom => ["doit être rempli(e)"]}
    end

    it "en erreur, nom contient trop de caractères" do
      @role.nom = "NicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolas"
      @role.should be_invalid
      @role.errors.messages.should == {:nom => ["est trop long (pas plus de 255 caractères)"]}
    end
  end

  describe "Suppression" do
    it "avec succès" do
      role = Role.create({nom: 'admin'})
      Role.destroy(role)
    end

    it "en erreur, le rôle est assigné à un utilisateur" do
      role = Role.create({nom: 'admin'})
      Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', email: 'nickdemers@gmail.com', numero_telephone: '418 777-5555',
                          niveau: 3, titre: 'Permanent', password: '12345678', roles: [role]})
      role.destroy
      role.errors.messages.should == {:base => ["Le rôle ne peut pas être supprimé car il est assigné à un utilisateur.\n"]}
    end

    it "en erreur, le rôle a un utilisateur d'assigné" do
      user = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', email: 'nickdemers@gmail.com', numero_telephone: '418 777-5555',
                                 niveau: 3, titre: 'Permanent', password: '12345678'})
      role = Role.create({nom: 'admin', utilisateurs: [user]})
      role.destroy
      role.errors.messages.should == {:base => ["Le rôle ne peut pas être supprimé car il est assigné à un utilisateur.\n"]}
    end
  end
end
