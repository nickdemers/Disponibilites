require 'spec_helper'

describe Disponibilite do
  describe "Création" do
    it "avec succès" do
      expect(FactoryGirl.create(:disponibilite_disponible)).to be_valid
    end

    it "en erreur, doit contenir l'identifiant de l'utilisateur absent" do
      Disponibilite.create({ecole_id: 22, niveau_id: 33, date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:utilisateur_absent_id => ["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir l'identifiant de l'école" do
      Disponibilite.create({utilisateur_absent_id: 11, niveau_id: 33, date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:ecole_id => ["doit être rempli(e)", "n'est pas un nombre"]}
    end

    it "en erreur, doit contenir l'identifiant du niveau" do
      Disponibilite.create({utilisateur_absent_id: 11, ecole_id: 22, date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:niveau_id => ["doit être rempli(e)", "n'est pas un nombre"]}
    end

    it "en erreur, doit contenir la date heure du début" do
      Disponibilite.create({utilisateur_absent_id: 11, ecole_id: 22, niveau_id: 33, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:date_heure_debut => ["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir la date heure de fin" do
      Disponibilite.create({utilisateur_absent_id: 11, ecole_id: 22, niveau_id: 33, date_heure_debut: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:date_heure_fin => ["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir le statut" do
      Disponibilite.create({utilisateur_absent_id: 11, ecole_id: 22, niveau_id: 33, date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 1.hour}).errors.messages.should == {:statut => ["doit être rempli(e)"]}
    end

    #it "en erreur, l'identifiant de l'utilisateur absent doit être numérique" do
    #  Disponibilite.create({utilisateur_absent_id: 'absent', ecole_id: 22, niveau_id: 33, date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:utilisateur_absent_id => ["n'est pas un nombre"]}
    #end

    #it "en erreur, l'identifiant de l'utilisateur remplacant doit être numérique" do
    #  Disponibilite.create({utilisateur_absent_id: 11, utilisateur_remplacant_id: 'remplacant', ecole_id: 22, niveau_id: 33, date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:utilisateur_remplacant_id => ["n'est pas un nombre"]}
    #end

    it "en erreur, l'identifiant de l'école doit être numérique" do
      Disponibilite.create({utilisateur_absent_id: 11, ecole_id: 'ecole', niveau_id: 33, date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:ecole_id => ["n'est pas un nombre"]}
    end

    it "en erreur, l'identifiant du niveau doit être numérique" do
      Disponibilite.create({utilisateur_absent_id: 11, ecole_id: 22, niveau_id: 'niveau', date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:niveau_id => ["n'est pas un nombre"]}
    end

    it "en erreur, la date heure debut doit être avant la date heure fin" do
      Disponibilite.create({utilisateur_absent_id: 11, ecole_id: 22, niveau_id: 33, date_heure_debut: DateTime.now + 2.hour, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:base => ["La date heure de début de la disponibilité doit être avant la date heure de fin.\n"]}
    end

    describe "validation de date heure debut et date heure fin" do
      it "en erreur, la date heure debut ne peut être dans le passé" do
        Disponibilite.create({utilisateur_absent_id: 11, ecole_id: 22, niveau_id: 33, date_heure_debut: DateTime.now - 1.day, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:base => ["Les dates de début et de fin ne peuvent pas être dans le passé.\n"]}
      end
    end

    it "en erreur, l'utilisateur remplaçant est déjà en remplacement" do
      Disponibilite.create({id: 1, utilisateur_absent_id: 11, utilisateur_remplacant_id: 44, ecole_id: 22, niveau_id: 33, date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 2.hour, statut: 'test'})
      Disponibilite.create({id: 2, utilisateur_absent_id: 22, utilisateur_remplacant_id: 44, ecole_id: 22, niveau_id: 33, date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 2.hour, statut: 'test'}).errors.messages.should == {:base => ["L'utilisateur remplaçant a déjà un remplacement dans ces heures.\n"]}
    end
  end
  describe "Modification" do
    before(:each) do
      @disponibilite = FactoryGirl.create(:disponibilite_disponible)
    end
    it "avec succès" do
      @utilisateur_absent = FactoryGirl.create(:utilisateur_permanent2)
      @utilisateur_remplacant = FactoryGirl.create(:utilisateur_remplacant)
      @ecole = FactoryGirl.create(:ecole)

      @disponibilite.ecole_id = @ecole
      @disponibilite.niveau_id = 14
      @disponibilite.date_heure_debut = DateTime.now + 2.minute
      @disponibilite.date_heure_fin = DateTime.now + 4.minute
      @disponibilite.statut = 'attribue'
      @disponibilite.utilisateur_absent = @utilisateur_absent
      @disponibilite.utilisateur_remplacant = @utilisateur_remplacant
      @disponibilite.surveillance = 'O'
      @disponibilite.specialite = 'O'
      @disponibilite.notes = 'note test'
      @disponibilite.should be_valid
    end

    it "en erreur, doit contenir l'identifiant de l'utilisateur absent" do
      @disponibilite.utilisateur_absent = nil
      @disponibilite.should be_invalid
      @disponibilite.errors.messages.should == {:utilisateur_absent_id=>["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir l'identifiant de l'école" do
      @disponibilite.ecole_id = nil
      @disponibilite.should be_invalid
      @disponibilite.errors.messages.should == {:ecole_id => ["doit être rempli(e)", "n'est pas un nombre"]}

      #@disponibilite.endroit = nil
      #@disponibilite.should be_invalid
      #@disponibilite.errors.messages.should == {:ecole_id => ["doit être rempli(e)", "n'est pas un nombre"]}
    end

    it "en erreur, doit contenir l'identifiant du niveau" do
      @disponibilite.niveau_id = nil
      @disponibilite.should be_invalid
      @disponibilite.errors.messages.should == {:niveau_id=>["doit être rempli(e)", "n'est pas un nombre"]}

    #  @disponibilite.niveau = nil
    #  @disponibilite.should be_invalid
    #  @disponibilite.errors.messages.should == {:niveau_id=>["doit être rempli(e)", "n'est pas un nombre"]}
    end

    it "en erreur, doit contenir la date heure du début" do
      @disponibilite.date_heure_debut = nil
      @disponibilite.should be_invalid
      @disponibilite.errors.messages.should == {:date_heure_debut=>["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir la date heure de fin" do
      @disponibilite.date_heure_fin = nil
      @disponibilite.should be_invalid
      @disponibilite.errors.messages.should == {:date_heure_fin=>["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir le statut" do
      @disponibilite.statut = nil
      @disponibilite.should be_invalid
      @disponibilite.errors.messages.should == {:statut=>["doit être rempli(e)"]}
    end

    #it "en erreur, l'identifiant de l'utilisateur remplacant doit être numérique" do
    #  @disponibilite.utilisateur_remplacant = 'remplacant'
    #  @disponibilite.should be_invalid
    #  @disponibilite.errors.messages.should == {:utilisateur_remplacant=>["n'est pas un nombre"]}
    #end

    it "en erreur, l'identifiant de l'école doit être numérique" do
      @disponibilite.ecole_id = 'ecole'
      @disponibilite.should be_invalid
      @disponibilite.errors.messages.should == {:ecole_id=>["n'est pas un nombre"]}
    end

    it "en erreur, l'identifiant du niveau doit être numérique" do
      @disponibilite.niveau_id = 'niveau'
      @disponibilite.should be_invalid
      @disponibilite.errors.messages.should == {:niveau_id=>["n'est pas un nombre"]}
    end

    it "en erreur, la date heure debut doit être avant la date heure fin" do
      @disponibilite.date_heure_debut= DateTime.now + 2.hour
      @disponibilite.date_heure_fin= DateTime.now + 1.hour
      @disponibilite.should be_invalid
      @disponibilite.errors.messages.should == {:base=>["La date heure de début de la disponibilité doit être avant la date heure de fin.\n"]}
    end

    describe "validation de date heure debut et date heure fin" do
      it "en erreur, la date heure debut ne peut être dans le passé" do
        @disponibilite.date_heure_debut= DateTime.now - 1.day
        @disponibilite.date_heure_fin= DateTime.now + 1.hour
        @disponibilite.should be_invalid
        @disponibilite.errors.messages.should == {:base=>["Les dates de début et de fin ne peuvent pas être dans le passé.\n"]}
      end
    end

    it "en erreur, l'utilisateur remplaçant est déjà en remplacement" do
      disponibilite1 = FactoryGirl.create(:disponibilite_attribue)
      @disponibilite.utilisateur_remplacant_id = 2
      @disponibilite.should be_invalid
      @disponibilite.errors.messages.should == {:base=>["L'utilisateur remplaçant a déjà un remplacement dans ces heures.\n"]}
    end
  end

  describe "Suppression" do
    it "avec succès de statut disponible" do
      disponibilite = FactoryGirl.create(:disponibilite_disponible)
      Disponibilite.destroy(disponibilite)
    end
    it "avec succès de statut attribué" do
      disponibilite = FactoryGirl.create(:disponibilite_attribue)
      Disponibilite.destroy(disponibilite)
    end
  end
end
