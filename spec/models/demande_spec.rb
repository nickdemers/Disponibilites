require 'spec_helper'

describe Demande do
  describe "Création" do
    it "avec succès" do
      demande = FactoryGirl.create(:demande)
      expect(demande).to be_valid
    end

    it "en erreur, doit contenir un utilisateur" do
      demande = FactoryGirl.create(:demande)
      demande.user= nil
      expect(demande).to be_invalid
      expect(demande.user).to be_nil
      expect(demande.errors.messages).to eq({:user => ["doit être rempli(e)"]})
    end

    it "en erreur, doit contenir une disponibilité" do
      demande = FactoryGirl.create(:demande)
      demande.disponibilite= nil
      expect(demande).to be_invalid
      expect(demande.disponibilite).to be_nil
      expect(demande.errors.messages).to eq({:disponibilite => ["doit être rempli(e)"]})
    end
  end
end
