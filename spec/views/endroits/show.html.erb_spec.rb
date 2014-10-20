require 'spec_helper'

describe "endroits/show" do
  before(:each) do
    @endroit = assign(:endroit, stub_model(Endroit,
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
