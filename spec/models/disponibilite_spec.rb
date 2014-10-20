require 'spec_helper'

describe Disponibilite do
  describe "Création" do
    it "avec succès" do
      expect(FactoryGirl.create(:disponibilite_disponible)).to be_valid
    end

    it "en erreur, doit contenir l'identifiant de l'utilisateur absent" do
      Disponibilite.create({endroit_id: 22, niveau_id: 33, date_heure_debut: DateTime.now, date_heure_fin: DateTime.now, statut: 'test'}).should be_invalid
    end

    it "en erreur, doit contenir l'identifiant de l'endroit" do
      Disponibilite.create({utilisateur_absent_id: 11, niveau_id: 33, date_heure_debut: DateTime.now, date_heure_fin: DateTime.now, statut: 'test'}).should be_invalid
    end

    it "en erreur, doit contenir l'identifiant du niveau" do
      Disponibilite.create({utilisateur_absent_id: 11, endroit_id: 22, date_heure_debut: DateTime.now, date_heure_fin: DateTime.now, statut: 'test'}).should be_invalid
    end

    it "en erreur, doit contenir la date heure du début" do
      Disponibilite.create({utilisateur_absent_id: 11, endroit_id: 22, niveau_id: 33, date_heure_fin: DateTime.now, statut: 'test'}).should be_invalid
    end

    it "en erreur, doit contenir la date heure de fin" do
      Disponibilite.create({utilisateur_absent_id: 11, endroit_id: 22, niveau_id: 33, date_heure_debut: DateTime.now, statut: 'test'}).should be_invalid
    end

    it "en erreur, doit contenir le statut" do
      Disponibilite.create({utilisateur_absent_id: 11, endroit_id: 22, niveau_id: 33, date_heure_debut: DateTime.now, date_heure_fin: DateTime.now}).should be_invalid
    end

    it "en erreur, l'identifiant de l'utilisateur absent doit être numérique" do
      Disponibilite.create({utilisateur_absent_id: 'absent', endroit_id: 22, niveau_id: 33, date_heure_debut: DateTime.now, date_heure_fin: DateTime.now, statut: 'test'}).should be_invalid
    end

    it "en erreur, l'identifiant de l'utilisateur remplacant doit être numérique" do
      Disponibilite.create({utilisateur_absent_id: 11, utilisateur_remplacant_id: 'remplacant', endroit_id: 22, niveau_id: 33, date_heure_debut: DateTime.now, date_heure_fin: DateTime.now, statut: 'test'}).should be_invalid
    end

    it "en erreur, l'identifiant de l'endroit doit être numérique" do
      Disponibilite.create({utilisateur_absent_id: 11, endroit_id: 'endroit', niveau_id: 33, date_heure_debut: DateTime.now, date_heure_fin: DateTime.now, statut: 'test'}).should be_invalid
    end

    it "en erreur, l'identifiant du niveau doit être numérique" do
      Disponibilite.create({utilisateur_absent_id: 11, endroit_id: 22, niveau_id: 'niveau', date_heure_debut: DateTime.now, date_heure_fin: DateTime.now, statut: 'test'}).should be_invalid
    end

    it "en erreur, la date heure debut doit être avant la date heure fin" do
      Disponibilite.create({utilisateur_absent_id: 11, endroit_id: 22, niveau_id: 33, date_heure_debut: DateTime.now + 2.hour, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:base => ["La date heure de début de la disponibilité doit être avant la date heure de fin.\n"]}
    end

    describe "validation de date heure debut et date heure fin" do
      it "en erreur, la date heure debut ne peut être dans le passé" do
        Disponibilite.create({utilisateur_absent_id: 11, endroit_id: 22, niveau_id: 33, date_heure_debut: DateTime.now - 1.day, date_heure_fin: DateTime.now, statut: 'test'}).errors.messages.should == {:base => ["Les dates de début et de fin ne peuvent pas être dans le passé.\n"]}
      end
    end

    it "en erreur, l'utilisateur remplaçant est déjà en remplacement" do
      Disponibilite.create({utilisateur_absent_id: 11, utilisateur_remplacant_id: 44, endroit_id: 22, niveau_id: 33, date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 2.hour, statut: 'test'})
      Disponibilite.create({utilisateur_absent_id: 22, utilisateur_remplacant_id: 44, endroit_id: 22, niveau_id: 33, date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 2.hour, statut: 'test'}).errors.messages.should == {:base => ["L'utilisateur remplaçant a déjà un remplacement dans ces heures.\n"]}
    end
  end
end
