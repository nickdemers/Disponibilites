#encoding=utf-8
require 'spec_helper'

describe HomeController do
  #routes { HomeController::Engine.routes }
  describe "valid session" do
    describe "Menu avec des disponibilités" do
      it "utilisateur connecté, afficher le contenu" do
        utilisateur_session = double('utilisateur')
        allow(request.env['warden']).to receive(:authenticate!) { utilisateur_session }

        disponibilite_dispo = FactoryGirl.create(:disponibilite_disponible)
        Disponibilite.stub_chain(:where).and_return(disponibilite_dispo)

        disponibilite = create(:disponibilite_disponible)

        allow(Disponibilite).to receive(:where).with("(statut = 'attente' or statut = 'disponible') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) {disponibilite}
        allow(disponibilite).to receive(:order).with("date_heure_debut") {disponibilite}
        allow(disponibilite).to receive(:first).with(10) {disponibilite}

        allow(Disponibilite).to receive(:all) {[disponibilite]}

        get 'index'

      end
    end
    describe "Menu sans disponibilité" do
      it "utilisateur connecté, afficher le contenu" do
        utilisateur_session = double('utilisateur')
        allow(request.env['warden']).to receive(:authenticate!) { utilisateur_session }

        allow(Disponibilite).to receive(:where).with("(statut = 'attente' or statut = 'disponible') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) {nil}
        allow(Disponibilite).to receive(:all) {[nil]}

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