require 'spec_helper'

describe "niveaus/index" do
  before(:each) do
    assign(:niveaus, [
      stub_model(Niveau,
        :nom => "Nom"
      ),
      stub_model(Niveau,
        :nom => "Nom"
      )
    ])
  end

  it "renders a list of niveaus" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nom".to_s, :count => 2
  end
end
