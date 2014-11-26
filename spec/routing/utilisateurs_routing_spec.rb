require "spec_helper"

describe UtilisateursController do
  describe "routing" do

    it "routes to #index" do
      get("/utilisateurs").should route_to("utilisateurs#index")
    end

    it "routes to #new" do
      get("/utilisateurs/new").should route_to("utilisateurs#new")
    end

    it "routes to #show" do
      get("/utilisateurs/1").should route_to("utilisateurs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/utilisateurs/1/edit").should route_to("utilisateurs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/utilisateurs").should route_to("utilisateurs#create")
    end

    it "routes to #update" do
      put("/utilisateurs/1").should route_to("utilisateurs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/utilisateurs/1").should route_to("utilisateurs#destroy", :id => "1")
    end

  end
end
