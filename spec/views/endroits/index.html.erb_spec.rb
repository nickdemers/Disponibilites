require 'spec_helper'

describe "endroits/index" do
  before(:each) do
    assign(:endroits, [
      stub_model(Endroit,
        :nom => "Nom",
        :adresse => "Adresse",
        :numero_telephone => "Numero Telephone"
      ),
      stub_model(Endroit,
        :nom => "Nom",
        :adresse => "Adresse",
        :numero_telephone => "Numero Telephone"
      )
    ])
  end

  it "renders a list of endroits" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nom".to_s, :count => 2
    assert_select "tr>td", :text => "Adresse".to_s, :count => 2
    assert_select "tr>td", :text => "Numero Telephone".to_s, :count => 2
  end
end
