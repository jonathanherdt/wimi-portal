require 'rails_helper'


RSpec.describe RequestsController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @chair = FactoryGirl.create(:chair)
    @representative = FactoryGirl.create(:user)
    ChairWimi.create(user_id: @representative.id, chair_id: @chair.id, representative: true)
  end

  describe 'GET #requests' do
    it 'does not show requests for users' do
      sign_in @user
      get :requests, {id: @chair}
      expect(response).to have_http_status(302)
    end

    it 'shows request page for chairs representative' do
      sign_in @representative
      get :requests, {id: @chair}
      expect(response).to have_http_status(:success)
    end

    it 'does not show request page for another chair' do
      chair1 = FactoryGirl.create(:chair)
      sign_in @representative
      get :requests, {id: chair1}
      expect(response).to have_http_status(302)
    end
  end
end