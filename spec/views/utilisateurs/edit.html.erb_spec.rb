require 'spec_helper'

describe "utilisateurs/edit" do
  before(:each) do
    @utilisateur = assign(:utilisateur, stub_model(Utilisateur))
  end

  it "renders the edit utilisateur form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", utilisateur_path(@utilisateur), "post" do
    end
  end
end
