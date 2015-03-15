#encoding=utf-8
require 'spec_helper'

describe HomeController do
  describe "valid session" do
    describe "Menu avec des disponibilités" do
      it "utilisateur connecté, afficher le contenu" do
        utilisateur = FactoryGirl.create(:utilisateur_admin)
        role = FactoryGirl.create(:role)
        utilisateur.roles= [role]

        sign_in utilisateur

        disponibilite = create(:disponibilite_disponible)

        allow(Disponibilite).to receive(:where).with("(statut = 'attente' or statut = 'disponible') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) {disponibilite}
        allow(disponibilite).to receive(:order).with("date_heure_debut") {disponibilite}
        allow(disponibilite).to receive(:first).with(10) {disponibilite}

        get 'index'

      end
    end
    describe "Menu sans disponibilité" do
      it "utilisateur connecté, afficher le contenu" do
        utilisateur = FactoryGirl.create(:utilisateur_admin)
        role = FactoryGirl.create(:role)
        utilisateur.roles= [role]

        sign_in utilisateur

        allow(Disponibilite).to receive(:where).with("(statut = 'attente' or statut = 'disponible') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) {nil}

        get 'index'
      end
    end
  end
  it "invalid session" do
    allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :utilisateur})

    get 'index'

    response.should redirect_to(new_utilisateur_session_path)
  end
end