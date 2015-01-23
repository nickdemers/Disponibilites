require 'spec_helper'

describe "etablissements/show" do
  before(:each) do
    @ecole = assign(:ecole, stub_model(Ecole,
      :nom => "Nom",
      :adresse => "Adresse",
      :numero_telephone => "Numero Telephone"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nom/)
    rendered.should match(/Adresse/)
    rendered.should match(/Numero Telephone/)
  end
end
