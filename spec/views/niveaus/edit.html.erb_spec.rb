require 'spec_helper'

describe "niveaus/edit" do
  before(:each) do
    @niveau = assign(:niveau, stub_model(Niveau,
      :nom => "MyString"
    ))
  end

  it "renders the edit niveau form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", niveau_path(@niveau), "post" do
      assert_select "input#niveau_nom[name=?]", "niveau[nom]"
    end
  end
end
