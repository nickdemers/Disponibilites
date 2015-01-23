require 'spec_helper'

describe "etablissements/edit" do
  before(:each) do
    @ecole = assign(:ecole, stub_model(Ecole,
      :nom => "MyString",
      :adresse => "MyString",
      :numero_telephone => "MyString"
    ))
  end

  it "renders the edit etablissement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", etablissement_path(@ecole), "post" do
      assert_select "input#etablissement_nom[name=?]", "etablissement[nom]"
      assert_select "input#etablissement_adresse[name=?]", "etablissement[adresse]"
      assert_select "input#etablissement_numero_telephone[name=?]", "etablissement[numero_telephone]"
    end
  end
end
