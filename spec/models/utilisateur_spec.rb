#encoding=utf-8
require 'spec_helper'

describe Utilisateur do

  describe "Création" do
    it "avec succès" do
      expect(FactoryGirl.create(:utilisateur_permanent)).to be_valid
    end

    it "en erreur, doit contenir un courriel" do
      Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', message_texte_permis: 'non', niveau: 3,
                          numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent'}).should be_invalid
    end

    it "en erreur, doit contenir un prénom" do
      Utilisateur.create({nom: 'Demers', courriel: 'nickdemers@gmail.com', message_texte_permis: 'non', niveau: 3,
                          numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent'}).should be_invalid
    end

    it "en erreur, doit contenir un nom" do
      Utilisateur.create({prenom: 'Nicolas', courriel: 'nickdemers@gmail.com', message_texte_permis: 'non', niveau: 3,
                          numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent'}).should be_invalid
    end

    it "en erreur, doit contenir un numéro de téléphone" do
      Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', courriel: 'nickdemers@gmail.com', message_texte_permis: 'non',
                          niveau: 3, numero_cellulaire: '418 999-8888', titre: 'Permanent'}).should be_invalid
    end

    it "en erreur, doit contenir un titre" do
      Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', courriel: 'nickdemers@gmail.com', message_texte_permis: 'non',
                          niveau: 3, numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555'}).should be_invalid
    end

    it "en erreur, prénom contient trop de caractères" do
      Utilisateur.create({prenom: 'NicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolas',
                          nom: 'Demers', courriel: 'nickdemers@gmail.com', numero_telephone: '418 777-5555', titre: 'Permanent'}).should be_invalid
    end

    it "en erreur, niveau doit être numérique" do
      Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', courriel: 'nickdemers@gmail.com', message_texte_permis: 'non',
                          niveau: 'test', numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent'}).should be_invalid
    end
  end

  describe "Mise à jour" do
    before(:each) do
      @user = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', courriel: 'nickdemers@gmail.com', numero_telephone: '418 777-5555',
          niveau: 3, titre: 'Permanent'})
    end
    it "avec succès" do
      @user.prenom = 'prenomTest'
      @user.nom = 'nomTest'
      @user.courriel = 'test@gmail.com'
      @user.numero_telephone = '418 888-8888'
      @user.titre = 'titreTest'
      @user.should be_valid
    end

    it "en erreur, doit contenir un courriel" do
      @user.courriel = nil
      @user.should be_invalid
    end

    it "en erreur, doit contenir un prénom" do
      @user.prenom = nil
      @user.should be_invalid
    end

    it "en erreur, doit contenir un nom" do
      @user.nom = nil
      @user.should be_invalid
    end

    it "en erreur, doit contenir un numéro téléphone" do
      @user.numero_telephone = nil
      @user.should be_invalid
    end

    it "en erreur, doit contenir un titre" do
      @user.titre = nil
      @user.should be_invalid
    end

    it "en erreur, niveau doit être numérique" do
      @user.niveau = 'test'
      @user.should be_invalid
    end

    it "en erreur, prénom contient trop de caractères" do
      @user.prenom = 'NicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolas'
      @user.should be_invalid
    end
  end

  #TODO Suppression, voir supprime ou mettre date_fin, permettre de supprimer même si présent dans Remplacement ?
  describe "Suppression" do
    it "avec succès" do
      user = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', courriel: 'nickdemers@gmail.com', numero_telephone: '418 777-5555',
                                 titre: 'Permanent'})
      user.delete.should be_valid
    end
    it "en erreur, utilisateur contenu dans remplacement" do
      userProfesseur = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', courriel: 'nickdemers@gmail.com', numero_telephone: '418 777-5555',
                                           titre: 'Permanent'})
      userRemplacant = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', courriel: 'nickdemers@gmail.com', numero_telephone: '418 777-5555',
                                           titre: 'Remplacant'})
      remplacement = Remplacement.create({id_event_calendar: 'id_event_calendar', id_utilisateur: userProfesseur.id, id_utilisateur_remplacant: userRemplacant.id,
                                          statut: 'statut'})
      userRemplacant.delete.should be_invalid
    end
  end
end