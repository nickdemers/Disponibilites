require 'spec_helper'

RSpec.describe ApplicationController, :type => :controller do
  controller do
    include DisponibilitesConcern
  end

  describe "date_heure_limit_answer" do
    it 'return date heure limit' do
      disponibilite = FactoryGirl.create(:disponibilite_disponible)

      date_heure_limit = subject.date_heure_limit_answer(disponibilite)

      expect(date_heure_limit).to eq (DateTime.now + 3.hours).strftime("%Y/%m/%d %l:%M %p")
    end

    it 'return nil when model is nil' do
      date_heure_limit = subject.date_heure_limit_answer(nil)

      expect(date_heure_limit).to be_nil
    end

    it 'return nil when create_at is nil' do
      disponibilite = FactoryGirl.create(:disponibilite_disponible)
      disponibilite.created_at = nil

      date_heure_limit = subject.date_heure_limit_answer(disponibilite)

      expect(date_heure_limit).to be_nil
    end
  end

  describe "get_disponibilites" do
    before(:each) do
      @user = FactoryGirl.create(:user_admin)
      role = FactoryGirl.create(:role)
      @user.roles= [role]
      sign_in @user
      allow(controller).to receive(:current_user) { @user }
    end

    it "without params Date and user admin" do
      expect(@user).to receive(:role?).with(:admin) {true}

      disponibilite = double

      expect(Disponibilite).to receive(:by_statut_waiting_available) {disponibilite}
      expect(disponibilite).to receive(:by_between_date_debut_fin).with(Date.current, Date.current + 2.months) {disponibilite}

      subject.get_disponibilites
    end

    it "without params Date and user permanent" do
      expect(@user).to receive(:role?).with(:admin) {false}
      expect(@user).to receive(:role?).with(:super_admin) {false}
      expect(@user).to receive(:role?).with(:permanent) {true}

      disponibilite = double
      user_id = double

      expect(@user).to receive(:id) {user_id}

      expect(Disponibilite).to receive(:by_statut_waiting_available) {disponibilite}
      expect(disponibilite).to receive(:by_between_date_debut_fin).with(Date.current, Date.current + 2.months) {disponibilite}
      expect(disponibilite).to receive(:by_user_absent).with(user_id) {disponibilite}

      subject.get_disponibilites
    end

    it "without params Date and user remplacant" do
      expect(@user).to receive(:role?).with(:admin) {false}
      expect(@user).to receive(:role?).with(:super_admin) {false}
      expect(@user).to receive(:role?).with(:permanent) {false}
      expect(@user).to receive(:role?).with(:remplacant) {true}

      disponibilite = double
      user_id = double

      expect(@user).to receive(:id) {user_id}

      expect(Disponibilite).to receive(:by_statut_waiting_available) {disponibilite}
      expect(disponibilite).to receive(:by_between_date_debut_fin).with(Date.current, Date.current + 2.months) {disponibilite}
      expect(disponibilite).to receive(:by_user_remplacant).with(user_id) {disponibilite}

      subject.get_disponibilites
    end

    it "with params Date" do
      expect(@user).to receive(:role?).with(:admin) {true}

      disponibilite = double

      expect(Disponibilite).to receive(:by_statut_waiting_available) {disponibilite}
      expect(disponibilite).to receive(:by_between_date_debut_fin).with(Date.current, Date.current + 2.months) {disponibilite}

      subject.get_disponibilites(Date.current , Date.current + 2.months)
    end
  end

  describe "get_disponibilites_avenir_non_attribue" do
    before(:each) do
      @user = FactoryGirl.create(:user_admin)
      role = FactoryGirl.create(:role)
      @user.roles= [role]
      sign_in @user
      allow(controller).to receive(:current_user) { @user }
    end

    specify "with list disponibilite" do
      disponibilites = double

      expect(controller).to receive(:get_disponibilites).with(Date.current , Date.current + 2.months) {disponibilites}

      expect(disponibilites).to receive(:nil?) {false}

      expect(disponibilites).to receive(:order).with("date_heure_debut") {disponibilites}
      expect(disponibilites).to receive(:first).with(10) {disponibilites}

      subject.get_disponibilites_avenir_non_attribue
    end

    specify "no list disponibilite" do
      disponibilites = double

      expect(controller).to receive(:get_disponibilites).with(Date.current , Date.current + 2.months) {disponibilites}

      expect(disponibilites).to receive(:nil?) {true}

      subject.get_disponibilites_avenir_non_attribue
    end
  end
end