require 'spec_helper'

describe "utilisateurs/new" do
  before(:each) do
    assign(:utilisateur, stub_model(Utilisateur).as_new_record)
  end

  it "renders new utilisateur form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", utilisateurs_path, "post" do
    end
  end
end
