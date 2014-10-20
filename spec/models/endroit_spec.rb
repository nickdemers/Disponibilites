require 'spec_helper'

describe Endroit do
  describe "Création" do
    it "avec succès" do
      Endroit.create({nom: 'Nom endroit'}).should be_valid
    end

    it "en erreur, doit contenir le nom de l'endroit" do
      Endroit.create({}).should be_invalid
    end
  end
end
