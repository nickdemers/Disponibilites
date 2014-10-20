require "spec_helper"

describe EndroitsController do
  describe "routing" do

    it "routes to #index" do
      get("/endroits").should route_to("endroits#index")
    end

    it "routes to #new" do
      get("/endroits/new").should route_to("endroits#new")
    end

    it "routes to #show" do
      get("/endroits/1").should route_to("endroits#show", :id => "1")
    end

    it "routes to #edit" do
      get("/endroits/1/edit").should route_to("endroits#edit", :id => "1")
    end

    it "routes to #create" do
      post("/endroits").should route_to("endroits#create")
    end

    it "routes to #update" do
      put("/endroits/1").should route_to("endroits#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/endroits/1").should route_to("endroits#destroy", :id => "1")
    end

  end
end
