require 'spec_helper'

describe "utilisateurs/index" do
  before(:each) do
    assign(:utilisateurs, [
      stub_model(Utilisateur),
      stub_model(Utilisateur)
    ])
  end

  it "renders a list of utilisateurs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
