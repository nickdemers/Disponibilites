require 'spec_helper'

describe "disponibilites_bck/index" do
  before(:each) do
    assign(:disponibilites_bck, [
      stub_model(Disponibilite,
        :utilisateur_absent_id => 1,
        :utilisateur_remplacant_id => 2,
        :endroit_id => 3,
        :niveau_id => 4,
        :surveillance => false,
        :specialite => false,
        :notes => "MyText",
        :statut => "Statut"
      ),
      stub_model(Disponibilite,
        :utilisateur_absent_id => 1,
        :utilisateur_remplacant_id => 2,
        :endroit_id => 3,
        :niveau_id => 4,
        :surveillance => false,
        :specialite => false,
        :notes => "MyText",
        :statut => "Statut"
      )
    ])
  end

  it "renders a list of disponibilites_bck" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Statut".to_s, :count => 2
  end
end
