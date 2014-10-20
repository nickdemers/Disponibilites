require 'spec_helper'

describe "disponibilites/new" do
  before(:each) do
    assign(:disponibilite, stub_model(Disponibilite,
      :utilisateur_absent_id => 1,
      :utilisateur_remplacant_id => 1,
      :endroit_id => 1,
      :niveau_id => 1,
      :surveillance => false,
      :specialite => false,
      :notes => "MyText",
      :statut => "MyString"
    ).as_new_record)
  end

  it "renders new disponibilite form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", disponibilites_path, "post" do
      assert_select "input#disponibilite_utilisateur_absent_id[name=?]", "disponibilite[utilisateur_absent_id]"
      assert_select "input#disponibilite_utilisateur_remplacant_id[name=?]", "disponibilite[utilisateur_remplacant_id]"
      assert_select "input#disponibilite_endroit_id[name=?]", "disponibilite[endroit_id]"
      assert_select "input#disponibilite_niveau_id[name=?]", "disponibilite[niveau_id]"
      assert_select "input#disponibilite_surveillance[name=?]", "disponibilite[surveillance]"
      assert_select "input#disponibilite_specialite[name=?]", "disponibilite[specialite]"
      assert_select "textarea#disponibilite_notes[name=?]", "disponibilite[notes]"
      assert_select "input#disponibilite_statut[name=?]", "disponibilite[statut]"
    end
  end
end
