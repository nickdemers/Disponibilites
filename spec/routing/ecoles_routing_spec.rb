require "spec_helper"

describe EcolesController do
  describe "routing" do

    it "routes to #index" do
      get("/etablissements").should route_to("etablissements#index")
    end

    it "routes to #new" do
      get("/etablissements/new").should route_to("etablissements#new")
    end

    it "routes to #show" do
      get("/etablissements/1").should route_to("etablissements#show", :id => "1")
    end

    it "routes to #edit" do
      get("/etablissements/1/edit").should route_to("etablissements#edit", :id => "1")
    end

    it "routes to #create" do
      post("/etablissements").should route_to("etablissements#create")
    end

    it "routes to #update" do
      put("/etablissements/1").should route_to("etablissements#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/etablissements/1").should route_to("etablissements#destroy", :id => "1")
    end

  end
end
