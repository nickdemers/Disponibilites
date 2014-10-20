require 'spec_helper'

describe "niveaus/show" do
  before(:each) do
    @niveau = assign(:niveau, stub_model(Niveau,
      :nom => "Nom"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nom/)
  end
end
