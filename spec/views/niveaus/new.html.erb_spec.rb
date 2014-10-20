require 'spec_helper'

describe "niveaus/new" do
  before(:each) do
    assign(:niveau, stub_model(Niveau,
      :nom => "MyString"
    ).as_new_record)
  end

  it "renders new niveau form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", niveaus_path, "post" do
      assert_select "input#niveau_nom[name=?]", "niveau[nom]"
    end
  end
end
