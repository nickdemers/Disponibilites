require "spec_helper"

describe DisponibilitesController do
  describe "routing" do

    it "routes to #index" do
      get("/disponibilites").should route_to("disponibilites#index")
    end

    it "routes to #new" do
      get("/disponibilites/new").should route_to("disponibilites#new")
    end

    it "routes to #show" do
      get("/disponibilites/1").should route_to("disponibilites#show", :id => "1")
    end

    it "routes to #edit" do
      get("/disponibilites/1/edit").should route_to("disponibilites#edit", :id => "1")
    end

    it "routes to #create" do
      post("/disponibilites").should route_to("disponibilites#create")
    end

    it "routes to #update" do
      put("/disponibilites/1").should route_to("disponibilites#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/disponibilites/1").should route_to("disponibilites#destroy", :id => "1")
    end

  end
end
