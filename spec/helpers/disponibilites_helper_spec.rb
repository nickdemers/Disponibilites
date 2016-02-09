require 'spec_helper'

describe DisponibilitesHelper do

  describe "get description ecole" do
    it "with id and contain key" do
      description = get_description_ecole(1)
      description.should eq("École 1")
    end
    it "without id" do
      description = get_description_ecole(nil)
      description.should eq("")
    end
    it "not contain key" do
      description = get_description_ecole(7)
      description.should eq("")
    end
  end

  describe "get description statut" do
    it "with id and contain key" do
      description = get_description_statut('available')
      description.should eq("Disponible")
    end
    it "without id" do
      description = get_description_statut(nil)
      description.should eq("")
    end
    it "not contain key" do
      description = get_description_statut('test')
      description.should eq("")
    end
  end

  describe "get date heure formatted" do
    it "with date_heure_debut and date_heure_fin" do
      @disponibilite = build(:disponibilite_disponible)
      date_heure = get_date_heure_format
      date_heure.should eq(@disponibilite.date_heure_debut.strftime("%Y/%m/%d %l:%M %p") + " - " + @disponibilite.date_heure_fin.strftime("%Y/%m/%d %l:%M %p"))
    end

    it "without date_heure_debut and date_heure_fin" do
      @disponibilite = build(:disponibilite_without_dates)
      date_heure = get_date_heure_format
      date_heure.should eq("")
    end

    it "when disponibilite is nil" do
      @disponibilite = nil
      date_heure = get_date_heure_format
      date_heure.should eq("")
    end
  end

  describe "get date heure debut formatted" do
    it "with date_heure_debut" do
      @disponibilite = build(:disponibilite_disponible)
      date_heure_debut = get_date_heure_debut_format
      date_heure_debut.should eq(@disponibilite.date_heure_debut.strftime("%Y/%m/%d %l:%M %p"))
    end
    it "without date_heure_debut" do
      @disponibilite = build(:disponibilite_without_dates)
      date_heure_debut = get_date_heure_debut_format
      date_time = DateTime.now + 1.day
      date_heure_debut.should eq(date_time.change(hour: 7, min: 30).strftime("%Y/%m/%d %l:%M %p"))
    end
    it "when disponibilite is nil" do
      @disponibilite = nil
      date_heure_debut = get_date_heure_debut_format
      date_time = DateTime.now + 1.day
      date_heure_debut.should eq(date_time.change(hour: 7, min: 30).strftime("%Y/%m/%d %l:%M %p"))
    end
  end

  describe "get date heure fin formatted" do
    it "with date_heure_fin" do
      @disponibilite = build(:disponibilite_disponible)
      date_heure_fin = get_date_heure_fin_format
      date_heure_fin.should eq(@disponibilite.date_heure_fin.strftime("%Y/%m/%d %l:%M %p"))
    end
    it "without date_heure_fin" do
      @disponibilite = build(:disponibilite_without_dates)
      date_heure_fin = get_date_heure_fin_format
      date_time = DateTime.now + 1.day
      date_heure_fin.should eq(date_time.change(hour: 16, min: 30).strftime("%Y/%m/%d %l:%M %p"))
    end
    it "when disponibilite is nil" do
      @disponibilite = nil
      date_heure_fin = get_date_heure_fin_format
      date_time = DateTime.now + 1.day
      date_heure_fin.should eq(date_time.change(hour: 16, min: 30).strftime("%Y/%m/%d %l:%M %p"))
    end
  end

  describe "format_date_heure" do
    specify "with date heure" do
      format_dh = format_date_heure(DateTime.now)
      format_dh.should eq(DateTime.now.strftime("%Y/%m/%d %l:%M %p"))
    end
  end

  describe "get user_absent formatted" do
    it "with name and first name" do
      disponibilite = double
      user_absent = double
      user_nom = "nom"
      user_prenom = "prenom"

      expect(disponibilite).to receive(:user_absent).exactly(5) {user_absent}
      expect(user_absent).to receive(:nom).twice {user_nom}
      expect(user_absent).to receive(:prenom).twice {user_prenom}

      user_nom = get_user_absent_nom_format(disponibilite)

      user_nom.should eq("nom, prenom")
    end
    it "without name and first name" do
      disponibilite = double
      user_absent = double

      expect(disponibilite).to receive(:user_absent).exactly(2) {user_absent}
      expect(user_absent).to receive(:nom) {nil}

      user_nom = get_user_absent_nom_format(disponibilite)

      user_nom.should eq("")
    end
  end

  describe "get user_remplacant formatted" do
    it "with name and first name" do
      disponibilite = double
      user_remplacant = double
      user_nom = "nom"
      user_prenom = "prenom"

      expect(disponibilite).to receive(:user_remplacant).exactly(5) {user_remplacant}
      expect(user_remplacant).to receive(:nom).twice {user_nom}
      expect(user_remplacant).to receive(:prenom).twice {user_prenom}

      user_nom = get_user_remplacant_nom_format(disponibilite)

      user_nom.should eq("nom, prenom")
    end
    it "without name and first name" do
      disponibilite = double
      user_remplacant = double

      expect(disponibilite).to receive(:user_remplacant).exactly(2) {user_remplacant}
      expect(user_remplacant).to receive(:nom) {nil}

      user_nom = get_user_remplacant_nom_format(disponibilite)

      user_nom.should eq("")
    end
  end

  describe "is_time_expired?" do
    specify "return true" do
      date_time = DateTime.current - 8.hours

      result = is_time_expired?(date_time)

      expect(result).to eq true

    end

    specify "return false" do
      date_time = DateTime.current

      result = is_time_expired?(date_time)

      expect(result).to eq false
    end
  end
end
