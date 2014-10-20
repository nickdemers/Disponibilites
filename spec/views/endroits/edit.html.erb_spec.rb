require 'spec_helper'

describe "endroits/edit" do
  before(:each) do
    @endroit = assign(:endroit, stub_model(Endroit,
      :nom => "MyString",
      :adresse => "MyString",
      :numero_telephone => "MyString"
    ))
  end

  it "renders the edit endroit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", endroit_path(@endroit), "post" do
      assert_select "input#endroit_nom[name=?]", "endroit[nom]"
      assert_select "input#endroit_adresse[name=?]", "endroit[adresse]"
      assert_select "input#endroit_numero_telephone[name=?]", "endroit[numero_telephone]"
    end
  end
end
