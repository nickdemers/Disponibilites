require "spec_helper"

describe NiveausController do
  describe "routing" do

    it "routes to #index" do
      get("/niveaus").should route_to("niveaus#index")
    end

    it "routes to #new" do
      get("/niveaus/new").should route_to("niveaus#new")
    end

    it "routes to #show" do
      get("/niveaus/1").should route_to("niveaus#show", :id => "1")
    end

    it "routes to #edit" do
      get("/niveaus/1/edit").should route_to("niveaus#edit", :id => "1")
    end

    it "routes to #create" do
      post("/niveaus").should route_to("niveaus#create")
    end

    it "routes to #update" do
      put("/niveaus/1").should route_to("niveaus#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/niveaus/1").should route_to("niveaus#destroy", :id => "1")
    end

  end
end
