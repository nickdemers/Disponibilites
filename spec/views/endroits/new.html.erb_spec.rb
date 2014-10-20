require 'spec_helper'

describe "endroits/new" do
  before(:each) do
    assign(:endroit, stub_model(Endroit,
      :nom => "MyString",
      :adresse => "MyString",
      :numero_telephone => "MyString"
    ).as_new_record)
  end

  it "renders new endroit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", endroits_path, "post" do
      assert_select "input#endroit_nom[name=?]", "endroit[nom]"
      assert_select "input#endroit_adresse[name=?]", "endroit[adresse]"
      assert_select "input#endroit_numero_telephone[name=?]", "endroit[numero_telephone]"
    end
  end
end
