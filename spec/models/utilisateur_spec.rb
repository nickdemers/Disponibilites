#encoding=utf-8
require 'spec_helper'

describe Utilisateur do

  describe "Création" do
    it "avec succès" do
      FactoryGirl.create(:utilisateur_permanent)
    end

    it "avec succès avec roles" do
      role = Role.create({nom: 'admin'})
      utilisateur = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', message_texte_permis: 'non', niveau: 3, email: 'test@test.ca',
                                        numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent', password: '12345678', roles: [role]})
      expect(utilisateur.role?('admin')).to eql(role)
    end

    it "avec succès, rôle introuvalbe" do
      role = Role.create({nom: 'admin'})
      utilisateur = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', message_texte_permis: 'non', niveau: 3, email: 'test@test.ca',
                                        numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent', password: '12345678', roles: [role]})
      expect(utilisateur.role?('test')).to be_nil
    end

    it "en erreur, doit contenir un courriel" do
      Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', message_texte_permis: 'non', niveau: 3,
                          numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent', password: '12345678'}).errors.messages.should == {:email => ["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir un prénom" do
      Utilisateur.create({nom: 'Demers', email: 'nickdemers@gmail.com', message_texte_permis: 'non', niveau: 3,
                          numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent', password: '12345678'}).errors.messages.should == {:prenom => ["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir un nom" do
      Utilisateur.create({prenom: 'Nicolas', email: 'nickdemers@gmail.com', message_texte_permis: 'non', niveau: 3,
                          numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent', password: '12345678'}).errors.messages.should == {:nom => ["doit être rempli(e)"]}
    end

    #it "en erreur, doit contenir un mot de passe" do
    #  Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', email: 'nickdemers@gmail.com', message_texte_permis: 'non', niveau: 3,
    #                      numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent'}).errors.messages.should == {:password => ["doit être rempli(e)"]}
    #end

    #it "en erreur, mot de passe invalide" do
    #  Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', email: 'nickdemers@gmail.com', message_texte_permis: 'non', niveau: 3,
    #                      numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent', password: '12345'}).errors.messages.should == {:password => ["is too short (minimum is 8 characters)"]}
    #end

    it "en erreur, doit contenir un numéro de téléphone" do
      Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', email: 'nickdemers@gmail.com', message_texte_permis: 'non',
                          niveau: 3, numero_cellulaire: '418 999-8888', titre: 'Permanent', password: '12345678'}).errors.messages.should == {:numero_telephone => ["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir un titre" do
      Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', email: 'nickdemers@gmail.com', message_texte_permis: 'non',
                          niveau: 3, numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', password: '12345678'}).errors.messages.should == {:titre => ["doit être rempli(e)"]}
    end

    it "en erreur, prénom contient trop de caractères" do
      Utilisateur.create({prenom: 'NicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolas',
                          nom: 'Demers', email: 'nickdemers@gmail.com', numero_telephone: '418 777-5555', titre: 'Permanent', password: '12345678'}).errors.messages.should == {:prenom => ["est trop long (pas plus de 255 caractères)"]}
    end

    it "en erreur, niveau doit être numérique" do
      Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', email: 'nickdemers@gmail.com', message_texte_permis: 'non',
                          niveau: 'test', numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent', password: '12345678'}).errors.messages.should == {:niveau => ["n'est pas un nombre"]}
    end
  end

  describe "Mise à jour" do
    before(:each) do
      @user = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', email: 'nickdemers@gmail.com', numero_telephone: '418 777-5555',
          niveau: 3, titre: 'Permanent', password: '12345678'})
    end
    it "avec succès" do
      @user.prenom = 'prenomTest'
      @user.nom = 'nomTest'
      @user.email = 'test@gmail.com'
      @user.numero_telephone = '418 888-8888'
      @user.titre = 'titreTest'
      @user.password = '12345678'
      @user.should be_valid
    end

    it "en erreur, doit contenir un courriel" do
      @user.email = nil
      @user.should be_invalid
      @user.errors.messages.should == {:email => ["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir un prénom" do
      @user.prenom = nil
      @user.should be_invalid
      @user.errors.messages.should == {:prenom => ["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir un nom" do
      @user.nom = nil
      @user.should be_invalid
      @user.errors.messages.should == {:nom => ["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir un numéro téléphone" do
      @user.numero_telephone = nil
      @user.should be_invalid
      @user.errors.messages.should == {:numero_telephone => ["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir un titre" do
      @user.titre = nil
      @user.should be_invalid
      @user.errors.messages.should == {:titre => ["doit être rempli(e)"]}
    end

    #it "en erreur, doit contenir un mot de passe" do
    #  @user.password = nil
    #  @user.should be_invalid
    #  @user.errors.messages.should == {:password => ["doit être rempli(e)"]}
    #end

    #it "en erreur, mot de passe invalide" do
    #  @user.password = '123'
    #  @user.should be_invalid
    #  @user.errors.messages.should == {:password => ["is too short (minimum is 8 characters)"]}
    #end

    it "en erreur, niveau doit être numérique" do
      @user.niveau = 'test'
      @user.should be_invalid
      @user.errors.messages.should == {:niveau => ["n'est pas un nombre"]}
    end

    it "en erreur, prénom contient trop de caractères" do
      @user.prenom = 'NicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolas'
      @user.should be_invalid
      @user.errors.messages.should == {:prenom => ["est trop long (pas plus de 255 caractères)"]}
    end
  end

  #TODO Suppression, voir supprime ou mettre date_fin, permettre de supprimer même si présent dans Disponibilité ?
  describe "Suppression" do
    it "avec succès" do
      user = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', email: 'nickdemers@gmail.com', numero_telephone: '418 777-5555',
                                  niveau: 3, titre: 'Permanent', password: '12345678'})
      Utilisateur.destroy(user)
    end

    it "avec succès avec rôle" do
      role = Role.create({nom: 'admin'})
      user = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', email: 'nickdemers@gmail.com', numero_telephone: '418 777-5555',
                                  niveau: 3, titre: 'Permanent', password: '12345678', roles: [role]})
      Utilisateur.destroy(user)
    end

    it "en erreur, utilisateur remplacant contenu dans une disponibilité" do
      userPermanent = FactoryGirl.create(:utilisateur_permanent)
      disponibilite = FactoryGirl.create(:disponibilite_attribue)
      disponibilite.utilisateur_absent_id= userPermanent
      expect {userPermanent.destroy}.to raise_exception
    end

    it "en erreur, utilisateur remplacant contenu dans une disponibilité" do
      userPermanent = FactoryGirl.create(:utilisateur_permanent)
      userRemplacant = FactoryGirl.create(:utilisateur_remplacant)
      disponibilite = FactoryGirl.create(:disponibilite_attribue)
      disponibilite.utilisateur_absent_id= userPermanent
      disponibilite.utilisateur_remplacant_id= userRemplacant
      expect {userRemplacant.destroy}.to raise_exception
    end

  end

  describe "Authentification" do
    it "succes" do
      Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', email: 'nickdemers@gmail.com', numero_telephone: '418 777-5555',
                          niveau: 3, titre: 'Permanent', password: '12345678'})
      userAuthenticate = Utilisateur.authenticate('nickdemers@gmail.com','12345678')
      userAuthenticate.should_not be_nil
    end

    it "en erreur, courriel de l'utilisateur introuvable" do
      Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', email: 'nickdemers@gmail.com', numero_telephone: '418 777-5555',
                          niveau: 3, titre: 'Permanent', password: '12345678'})
      userAuthenticate = Utilisateur.authenticate('nickdemerssss@gmail.com','12345678')
      userAuthenticate.should be_nil
    end

    it "en erreur, mot de passe de l'utilisateur non valide" do
      Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', email: 'nickdemers@gmail.com', numero_telephone: '418 777-5555',
                          niveau: 3, titre: 'Permanent', password: '12345678'})
      userAuthenticate = Utilisateur.authenticate('nickdemers@gmail.com','11111111')
      userAuthenticate.should be_nil
    end
  end
end