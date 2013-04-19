#encoding=utf-8
require 'spec_helper'

describe Remplacement do

  describe "Création" do
    it "avec succès" do
      Remplacement.create({id_event_calendar: 'id_event_calendar', id_utilisateur: 1111, id_utilisateur_remplacant: 2222,
                           statut: 'statut'}).should be_valid
    end

    it "en erreur, doit contenir un id_event_calendar" do
      Remplacement.create({id_utilisateur: 1111, id_utilisateur_remplacant: 2222,
                           statut: 'statut'}).should be_invalid
    end

    it "en erreur, doit contenir un id_utilisateur" do
      Remplacement.create({id_event_calendar: 'id_event_calendar', id_utilisateur_remplacant: 2222,
                           statut: 'statut'}).should be_invalid
    end

    it "en erreur, id_utilisateur doit numérique" do
      Remplacement.create({id_event_calendar: 'id_event_calendar', id_utilisateur: 'test', id_utilisateur_remplacant: 2222,
                           statut: 'statut'}).should be_invalid
    end

    it "en erreur, doit contenir un id_utilisateur_remplacant" do
      Remplacement.create({id_event_calendar: 'id_event_calendar', id_utilisateur: 1111,
                           statut: 'statut'}).should be_invalid
    end

    it "en erreur, id_utilisateur_remplacant doit numérique" do
      Remplacement.create({id_event_calendar: 'id_event_calendar', id_utilisateur: 1111, id_utilisateur_remplacant: 'test',
                           statut: 'statut'}).should be_invalid
    end

    it "en erreur, doit contenir un statut" do
      Remplacement.create({id_event_calendar: 'id_event_calendar', id_utilisateur: 1111, id_utilisateur_remplacant: 2222}).should be_invalid
    end
  end

  describe "Mise à jour" do
    it "avec succès" do
      remp = Remplacement.create({id_event_calendar: 'id_event_calendar', id_utilisateur: 1111, id_utilisateur_remplacant: 2222,
                                  statut: 'statut'})
      remp.id_event_calendar = 'id_event_calendar2'
      remp.id_utilisateur = 3333
      remp.id_utilisateur_remplacant = 4444
      remp.statut = 'statutTest'
      remp.should be_valid
    end

    it "en erreur, doit contenir un id_event_calendar" do
      remp = Remplacement.create({id_event_calendar: 'id_event_calendar', id_utilisateur: 1111, id_utilisateur_remplacant: 2222,
                                  statut: 'statut'})
      remp.id_event_calendar = nil
      remp.should be_invalid
    end

    it "en erreur, doit contenir un id_utilisateur" do
      remp = Remplacement.create({id_event_calendar: 'id_event_calendar', id_utilisateur: 1111, id_utilisateur_remplacant: 2222,
                                  statut: 'statut'})
      remp.id_utilisateur = nil
      remp.should be_invalid
    end

    it "en erreur, id_utilisateur doit numérique" do
      remp = Remplacement.create({id_event_calendar: 'id_event_calendar', id_utilisateur: 1111, id_utilisateur_remplacant: 2222,
                                  statut: 'statut'})
      remp.id_utilisateur = 'test'
      remp.should be_invalid
    end

    it "en erreur, doit contenir un id_utilisateur_remplacant" do
      remp = Remplacement.create({id_event_calendar: 'id_event_calendar', id_utilisateur: 1111, id_utilisateur_remplacant: 2222,
                                  statut: 'statut'})
      remp.id_utilisateur_remplacant = nil
      remp.should be_invalid
    end

    it "en erreur, id_utilisateur_remplacant doit numérique" do
      remp = Remplacement.create({id_event_calendar: 'id_event_calendar', id_utilisateur: 1111, id_utilisateur_remplacant: 2222,
                                  statut: 'statut'})
      remp.id_utilisateur_remplacant = 'test'
      remp.should be_invalid
    end

    it "en erreur, doit contenir un statut" do
      remp = Remplacement.create({id_event_calendar: 'id_event_calendar', id_utilisateur: 1111, id_utilisateur_remplacant: 2222,
                                  statut: 'statut'})
      remp.statut = nil
      remp.should be_invalid
    end
  end
  #TODO Suppression, voir supprime ou mettre date_fin
end