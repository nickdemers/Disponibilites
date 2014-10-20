require 'spec_helper'

describe Niveau do
  describe "Création" do
    it "avec succès" do
      Niveau.create({nom: '1ere année', code: 1}).should be_valid
    end

    it "en erreur, doit contenir le nom du niveau" do
      Niveau.create({}).should be_invalid
    end

    it "en erreur, doit contenir le code du niveau" do
      Niveau.create({nom: '1ere année'}).should be_invalid
    end

    it "en erreur, le code du niveau doit être numérique" do
      Niveau.create({nom: '1ere année', code: 'test'}).should be_invalid
    end
  end
end
