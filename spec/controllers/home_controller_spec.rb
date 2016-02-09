#encoding=utf-8
require 'spec_helper'

describe HomeController do
  describe "valid session" do
    describe "Menu avec des disponibilités" do
      it "user connecté, afficher le contenu" do
        user = FactoryGirl.create(:user_admin)
        role = FactoryGirl.create(:role)
        user.roles= [role]

        sign_in user

        expect(controller).to receive(:get_disponibilites_avenir_non_attribue)

        get 'index'

      end
    end
  end
  it "invalid session" do
    allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})

    get 'index'

    expect(response).to redirect_to(new_user_session_path)
  end
end