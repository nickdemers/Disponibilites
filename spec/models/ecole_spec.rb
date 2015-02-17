require 'spec_helper'

describe Ecole do
  describe "Création" do
    it "avec succès" do
      expect(FactoryGirl.create(:ecole)).to be_valid
    end

    it "avec succès, assigné à plusieurs disponibilités" do
      ecole = FactoryGirl.create(:ecole)
      disponibilite = FactoryGirl.create(:disponibilite_disponible)
      disponibilite.ecole= ecole
      disponibilite.save
      disponibilite2 = FactoryGirl.create(:disponibilite_attribue)
      disponibilite2.ecole= ecole
      disponibilite2.save
    end

    it "en erreur, doit contenir un nom" do
      Ecole.create({}).errors.messages.should == {:nom => ["doit être rempli(e)"]}
    end

    it "en erreur, nom contient trop de caractères" do
      Ecole.create({:nom => "NicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolas"}).errors.messages.should == {:nom => ["est trop long (pas plus de 255 caractères)"]}
    end
  end

  describe "Mise à jour" do
    before(:each) do
      @ecole = FactoryGirl.create(:ecole)
    end
    it "avec succès" do
      @ecole.nom = 'autre école'
      @ecole.should be_valid
    end

    it "en erreur, doit contenir un nom" do
      @ecole.nom = nil
      @ecole.should be_invalid
      @ecole.errors.messages.should == {:nom => ["doit être rempli(e)"]}
    end

    it "en erreur, nom contient trop de caractères" do
      @ecole.nom = "NicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolasNicolas"
      @ecole.should be_invalid
      @ecole.errors.messages.should == {:nom => ["est trop long (pas plus de 255 caractères)"]}
    end
  end

  describe "Suppression" do
    it "avec succès" do
      ecole = FactoryGirl.create(:ecole)
      Ecole.destroy(ecole)
    end

    it "avec succès, non présente dans une disponibilité" do
      ecole = FactoryGirl.create(:ecole)
      disponibilite = FactoryGirl.create(:disponibilite_disponible)
      Ecole.destroy(ecole)
    end

    it "en erreur, l'école est assignée à une disponibilité" do
      ecole = FactoryGirl.create(:ecole)
      disponibilite = FactoryGirl.create(:disponibilite_disponible)
      disponibilite.ecole= ecole
      disponibilite.save
      ecole.destroy
      ecole.errors.messages.should == {:base => ["L'école ne peut pas être supprimée car elle est assignée à une disponibilité.\n"]}
    end
  end
end
