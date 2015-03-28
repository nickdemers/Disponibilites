require 'spec_helper'

describe "disponibilites_bck/show" do
  before(:each) do
    @disponibilite = assign(:disponibilite, stub_model(Disponibilite,
      :user_absent_id => 1,
      :user_remplacant_id => 2,
      :endroit_id => 3,
      :niveau_id => 4,
      :surveillance => false,
      :specialite => false,
      :notes => "MyText",
      :statut => "Statut"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/MyText/)
    rendered.should match(/Statut/)
  end
end
