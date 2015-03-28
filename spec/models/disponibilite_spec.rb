require 'spec_helper'

describe Disponibilite do
  describe "Création" do
    before :all do
      @ecole = FactoryGirl.create(:ecole)
    end

    it "avec succès" do
      expect(FactoryGirl.create(:disponibilite_disponible)).to be_valid
    end

    it "en erreur, doit contenir l'identifiant de l'utilisateur absent" do
      Disponibilite.create({ecole_id: @ecole.id, niveau_id: 33, date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:user_absent_id => ["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir l'identifiant de l'école" do
      Disponibilite.create({user_absent_id: 11, niveau_id: 33, date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:ecole_id => ["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir l'identifiant du niveau" do
      Disponibilite.create({user_absent_id: 11, ecole_id: @ecole.id, date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:niveau_id => ["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir la date heure du début" do
      Disponibilite.create({user_absent_id: 11, ecole_id: @ecole.id, niveau_id: 33, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:date_heure_debut => ["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir la date heure de fin" do
      Disponibilite.create({user_absent_id: 11, ecole_id: @ecole.id, niveau_id: 33, date_heure_debut: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:date_heure_fin => ["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir le statut" do
      Disponibilite.create({user_absent_id: 11, ecole_id: @ecole.id, niveau_id: 33, date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 1.hour}).errors.messages.should == {:statut => ["doit être rempli(e)"]}
    end

    #it "en erreur, l'identifiant de l'utilisateur absent doit être numérique" do
    #  Disponibilite.create({user_absent_id: 'absent', ecole_id: 22, niveau_id: 33, date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:user_absent_id => ["n'est pas un nombre"]}
    #end

    #it "en erreur, l'identifiant de l'utilisateur remplacant doit être numérique" do
    #  Disponibilite.create({user_absent_id: 11, user_remplacant_id: 'remplacant', ecole_id: 22, niveau_id: 33, date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:user_remplacant_id => ["n'est pas un nombre"]}
    #end

    it "en erreur, l'identifiant de l'école doit être numérique" do
      Disponibilite.create({user_absent_id: 11, ecole_id: 'ecole', niveau_id: 33, date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:ecole_id => ["n'est pas un nombre"]}
    end

    it "en erreur, l'identifiant du niveau doit être numérique" do
      Disponibilite.create({user_absent_id: 11, ecole_id: @ecole.id, niveau_id: 'niveau', date_heure_debut: DateTime.now + 1.hour, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:niveau_id => ["n'est pas un nombre"]}
    end

    describe "validation de date heure debut et date heure fin" do
      it "en erreur, la date heure debut ne peut être dans le passé" do
        Disponibilite.create({user_absent_id: 11, ecole_id: @ecole.id, niveau_id: 33, date_heure_debut: DateTime.now - 1.day, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:base => ["Les dates de début et de fin ne peuvent pas être dans le passé.\n"]}
      end

      it "en erreur, la date heure debut doit être avant la date heure fin" do
        Disponibilite.create({user_absent_id: 11, ecole_id: @ecole.id, niveau_id: 33, date_heure_debut: DateTime.now + 2.hour, date_heure_fin: DateTime.now + 1.hour, statut: 'test'}).errors.messages.should == {:base => ["La date heure de début de la disponibilité doit être avant la date heure de fin.\n"]}
      end
    end

    it "en erreur, l'utilisateur remplaçant est déjà en remplacement" do
      expect(Disponibilite.create({user_absent_id: 11, user_remplacant_id: 44, ecole_id: @ecole.id, niveau_id: 33, date_heure_debut: Time.now + 1.hour, date_heure_fin: Time.now + 2.hour, statut: 'assigned'})).to be_valid
      dispo = Disponibilite.create({user_absent_id: 22, user_remplacant_id: 44, ecole_id: @ecole.id, niveau_id: 33, date_heure_debut: Time.now + 1.hour, date_heure_fin: Time.now + 2.hour, statut: 'available'})
      dispo.should be_invalid
      expect(dispo.errors.messages).to eq({:base => ["L'utilisateur remplaçant a déjà un remplacement dans ces heures.\n"]})
    end
  end

  describe "Modification" do
    before(:each) do
      @disponibilite = FactoryGirl.create(:disponibilite_disponible)
    end
    it "avec succès" do
      @user_absent = FactoryGirl.create(:user_permanent2)
      @user_remplacant = FactoryGirl.create(:user_remplacant)
      ecole = FactoryGirl.create(:ecole)

      @disponibilite.ecole_id = ecole.id
      @disponibilite.niveau_id = 14
      @disponibilite.date_heure_debut = DateTime.now + 2.minute
      @disponibilite.date_heure_fin = DateTime.now + 4.minute
      @disponibilite.statut = 'assigned'
      @disponibilite.user_absent = @user_absent
      @disponibilite.user_remplacant = @user_remplacant
      @disponibilite.surveillance = 'O'
      @disponibilite.specialite = 'O'
      @disponibilite.notes = 'note test'
      @disponibilite.should be_valid
    end

    it "en erreur, doit contenir l'identifiant de l'utilisateur absent" do
      @disponibilite.user_absent = nil
      @disponibilite.should be_invalid
      @disponibilite.errors.messages.should == {:user_absent_id=>["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir l'identifiant de l'école" do
      @disponibilite.ecole_id= nil
      @disponibilite.should be_invalid
      @disponibilite.errors.messages.should == {:ecole_id => ["doit être rempli(e)"]}
    end

    it "en erreur, doit contenir l'identifiant du niveau" do
      @disponibilite.niveau_id = nil
      @disponibilite.should be_invalid
      @disponibilite.errors.messages.should == {:niveau_id=>["doit être rempli(e)"]}
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
    #  @disponibilite.user_remplacant = 'remplacant'
    #  @disponibilite.should be_invalid
    #  @disponibilite.errors.messages.should == {:user_remplacant=>["n'est pas un nombre"]}
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
      @disponibilite.user_remplacant_id = 2
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
