require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the DisponibilitesHelper. For example:
#
# describe DisponibilitesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe DisponibilitesHelper do
  #include SessionsHelper
  #include Devise::TestHelpers

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
      date_heure_debut.should eq(DateTime.now.strftime("%Y/%m/%d %l:%M %p"))
    end
    it "when disponibilite is nil" do
      @disponibilite = nil
      date_heure_debut = get_date_heure_debut_format
      date_heure_debut.should eq(DateTime.now.strftime("%Y/%m/%d %l:%M %p"))
    end
  end

  describe "get date heure fin formatted" do
    it "with date_heure_fin" do
      @disponibilite = build(:disponibilite_disponible)
      date_heure_fin = get_date_heure_fin_format
      date_heure_fin.should eq(@disponibilite.date_heure_fin.strftime("%Y/%m/%d %l:%M %p"))
    end
    it "without date_heure_debut" do
      @disponibilite = build(:disponibilite_without_dates)
      date_heure_fin = get_date_heure_fin_format
      date_heure_fin.should eq(DateTime.now.strftime("%Y/%m/%d %l:%M %p"))
    end
    it "when disponibilite is nil" do
      @disponibilite = nil
      date_heure_fin = get_date_heure_fin_format
      date_heure_fin.should eq(DateTime.now.strftime("%Y/%m/%d %l:%M %p"))
    end
  end

  describe "get user_remplacant formatted" do
    it "with name and first name" do
      @user_remplacant = build(:user_remplacant)
      user_nom = get_user_remplacant_nom_format
      user_nom.should eq("Demers remplacant, Nicolas")
    end
    it "without name and first name" do
      @user_remplacant = build(:user_remplacant_without_names)
      user_nom = get_user_remplacant_nom_format
      user_nom.should eq("")
    end
    it "without user remplacant" do
      @user_remplacant = nil
      user_nom = get_user_remplacant_nom_format
      user_nom.should eq("")
    end
  end

  describe "get_disponibilites_avenir_non_attribue" do
    describe "disponibilites finded" do
      it "without params Date" do
        user = FactoryGirl.create(:user_admin)
        role = FactoryGirl.create(:role)
        user.roles= [role]

        sign_in user

        disponibilite = build(:disponibilite_disponible)
        Disponibilite.stub_chain(:where, :order, :first).and_return(disponibilite)
        liste_disponibilites = get_disponibilites_avenir_non_attribue
        liste_disponibilites.should_not be_nil
      end
      it "with params Date" do
        disponibilite = build(:disponibilite_disponible)
        Disponibilite.stub_chain(:where, :order, :first).and_return(disponibilite)
        liste_disponibilites = get_disponibilites_avenir_non_attribue(Date.current + 1.days, Date.current + 2.days)
        liste_disponibilites.should_not be_nil
      end
    end
    describe "disponibilites not finded" do
      before(:each) do
        user = FactoryGirl.create(:user_admin)
        role = FactoryGirl.create(:role)
        user.roles= [role]

        sign_in user
      end
      it "without params Date" do
        allow(Disponibilite).to receive(:where).with("(statut = 'waiting' or statut = 'available') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) {nil}
        liste_disponibilites = get_disponibilites_avenir_non_attribue
        liste_disponibilites.should be_nil
      end
      it "with params Date" do
        allow(Disponibilite).to receive(:where).with("(statut = 'waiting' or statut = 'available') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) {nil}
        liste_disponibilites = get_disponibilites_avenir_non_attribue(Date.current + 1.days, Date.current + 2.days)
        liste_disponibilites.should be_nil
      end
    end
  end
end
