require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe TripsController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create(:user, signature: 'Signature')
    chair = FactoryGirl.create(:chair)
    FactoryGirl.create(:wimi, chair: chair, user: @user)
    login_with @user
  end

  # This should return the minimal set of attributes required to create a valid
  # Trip. As you add validations to Trip, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {destination: 'NYC Conference',
    reason: 'Hana Things',
    annotation: 'HANA pls',
    date_start: Date.today,
    date_end: Date.today+2,
    days_abroad: 1,
    signature: true,
    user: @user}
  }

  let(:valid_attributes_format) {
    {destination: 'NYC Conference',
    reason: 'Hana Things',
    annotation: 'HANA pls',
    date_start: I18n.l(Date.today, locale: 'en'),
    date_end: I18n.l(Date.today+2, locale: 'en'),
    days_abroad: 1,
    signature: true,
    user: @user}
  }

  let(:new_attributes_format) {
    {destination: 'NYC',
    reason: 'Hana ',
    annotation: 'HANA pls',
    date_start: I18n.l(Date.today+2, locale: 'en'),
    date_end: I18n.l(Date.today+4, locale: 'en'),
    days_abroad: 2,
    signature: false,
    user: @user}
  }

  let(:invalid_attributes) {
    {destination: '',
    reason: 'Hana Things',
    annotation: 'HANA pls',
    date_start: Date.today,
    date_end: Date.today-10,
    days_abroad: -20,
    signature: true,
    user: @user}
  }

  let(:invalid_attributes_format) {
    {destination: '',
    reason: 'Hana Things',
    annotation: 'HANA pls',
    date_start: I18n.l(Date.today, locale: 'en'),
    date_end: I18n.l(Date.today-10, locale: 'en'),
    days_abroad: -20,
    signature: true,
    user: @user}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TripsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all trips as @trips' do
      trip = Trip.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:trips)).to eq(Trip.where(user: @user))
    end
  end

  describe 'GET #show' do
    it 'assigns the requested trip as @trip' do
      trip = Trip.create! valid_attributes
      get :show, {id: trip.to_param}, valid_session
      expect(assigns(:trip)).to eq(trip)
    end
  end

  describe 'GET #new' do
    it 'assigns a new trip as @trip' do
      get :new, {}, valid_session
      expect(assigns(:trip)).to be_a_new(Trip)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested trip as @trip' do
      trip = Trip.create! valid_attributes
      get :edit, {id: trip.to_param}, valid_session
      expect(assigns(:trip)).to eq(trip)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Trip' do
        expect {
          post :create, {trip: valid_attributes_format}, valid_session
        }.to change(Trip, :count).by(1)
      end

      it 'assigns a newly created trip as @trip' do
        post :create, {trip: valid_attributes_format}, valid_session
        expect(assigns(:trip)).to be_a(Trip)
        expect(assigns(:trip)).to be_persisted
      end

      it 'redirects to the created trip' do
        post :create, {trip: valid_attributes_format}, valid_session
        expect(response).to redirect_to(Trip.last)
      end
      it 'has the status saved' do
        trip = Trip.create! valid_attributes
        expect(trip.status).to eq('saved')
      end

      it 'redirects to trips_path for normal user' do
        user = FactoryGirl.create(:user)
        login_with(user)
        expect{
          post :create, {trip: valid_attributes_format}, valid_session
        }.to change(Trip, :count).by(0)
        expect(response).to redirect_to(trips_path)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved trip as @trip' do
        post :create, {trip: invalid_attributes_format}, valid_session
        expect(assigns(:trip)).to be_a_new(Trip)
      end

      it "re-renders the 'new' template" do
        post :create, {trip: invalid_attributes_format}, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        {
            destination: 'NYC',
            reason: 'Hana',
            annotation: 'HANA',
            signature: false,
            user: User.first}
      }

      it 'updates the requested trip' do
        trip = Trip.create! valid_attributes
        put :update, {id: trip.to_param, trip: new_attributes_format}, valid_session
        trip.reload
        expect(trip.destination).to eq('NYC')
        expect(trip.status).to eq('saved')
      end

      it 'assigns the requested trip as @trip' do
        trip = Trip.create! valid_attributes
        put :update, {id: trip.to_param, trip: valid_attributes_format}, valid_session
        expect(assigns(:trip)).to eq(trip)
      end

      it 'redirects to the trip' do
        trip = Trip.create! valid_attributes
        put :update, {id: trip.to_param, trip: valid_attributes_format}, valid_session
        expect(response).to redirect_to(trip)
      end
    end

    context 'with invalid params' do
      it 'assigns the trip as @trip' do
        trip = Trip.create! valid_attributes
        put :update, {id: trip.to_param, trip: invalid_attributes_format}, valid_session
        expect(assigns(:trip)).to eq(trip)
      end

      it "re-renders the 'edit' template" do
        trip = Trip.create! valid_attributes
        put :update, {id: trip.to_param, trip: invalid_attributes_format}, valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested trip' do
      trip = Trip.create! valid_attributes
      expect {
        delete :destroy, {id: trip.to_param}, valid_session
      }.to change(Trip, :count).by(-1)
    end

    it 'can not destroy an applied trip' do
      trip = Trip.create! valid_attributes
      trip.user = @user
      login_with(@user)
      post :hand_in, {id: trip.id}
      expect {
        delete :destroy, {id: trip.to_param}, valid_session
      }.to change(Trip, :count).by(0)
    end

    it 'redirects to the trips list' do
      trip = Trip.create! valid_attributes
      delete :destroy, {id: trip.to_param}, valid_session
      expect(response).to redirect_to(trips_url)
    end

    it 'redirects to the trip, if it is already applied' do
      trip = Trip.create! valid_attributes
      trip.update_attributes(status: 'applied')
      get :edit, {id: trip.id}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(trip_path(trip))
    end
  end

  describe 'POST #hand_in' do
    it 'hands in a trip request' do
      trip = Trip.create! valid_attributes
      trip.user = @user
      login_with(@user)
      post :hand_in, {id: trip.id}
      expect(Trip.find(trip.id).status).to eq('applied')
    end

    it 'normal user can not hand in a trip request' do
      user = FactoryGirl.create(:user)
      trip = Trip.create! valid_attributes
      trip.user = user
      login_with(user)
      post :hand_in, {id: trip.id}
      expect(Trip.find(trip.id).status).to eq('saved')
    end
  end

  describe 'GET #accept' do
    context 'with valid params' do
      it 'redirects to the users page' do
        ChairWimi.first.update_attributes(user: @user, representative: true)
        trip = FactoryGirl.create(:trip, user: @user, status: 'applied')
        login_with(@user)
        post :hand_in, {id: trip.id}
        get :accept, {id: trip.to_param}, valid_session
        expect(response).to redirect_to(@user)
      end

      it 'redirects to root path if status is not applied' do
        ChairWimi.first.update_attributes(user: @user, representative: true)
        trip = FactoryGirl.create(:trip, user: @user, status: 'saved')
        login_with(@user)
        get :accept, {id: trip.to_param}, valid_session
        expect(response).to redirect_to(root_path)
      end

      it 'updates the status' do
        ChairWimi.first.update_attributes(user: @user, representative: true)
        trip = FactoryGirl.create(:trip, user: @user, status: 'applied')
        login_with(@user)
        post :hand_in, {id: trip.id}
        get :accept, {id: trip.to_param}, valid_session
        expect(Trip.find(trip.id).status).to eq('accepted')
      end
    end

    context 'with invalid params' do
      it 'redirects to the trips path if not chair representative' do
        trip = FactoryGirl.create(:trip, user: @user, status: 'applied')
        login_with(@user)
        post :hand_in, {id: trip.id}
        get :accept, {id: trip.to_param}, valid_session
        expect(response).to redirect_to(trips_path)
      end
    end
  end

  describe 'GET #reject' do
    context 'with valid params' do
      it 'redirects to the users page' do
        ChairWimi.first.update_attributes(user: @user, representative: true)
        trip = FactoryGirl.create(:trip, user: @user, status: 'applied')
        login_with(@user)
        post :hand_in, {id: trip.id}
        get :reject, {id: trip.to_param}, valid_session
        expect(response).to redirect_to(@user)
      end

      it 'redirects to root path if status is not applied' do
        ChairWimi.first.update_attributes(user: @user, representative: true)
        trip = FactoryGirl.create(:trip, user: @user, status: 'saved')
        login_with(@user)
        get :reject, {id: trip.to_param}, valid_session
        expect(response).to redirect_to(root_path)
      end

      it 'updates the status' do
        ChairWimi.first.update_attributes(user: @user, representative: true)
        trip = FactoryGirl.create(:trip, user: @user, status: 'applied')
        login_with(@user)
        post :hand_in, {id: trip.id}
        get :reject, {id: trip.to_param}, valid_session
        expect(Trip.find(trip.id).status).to eq('declined')
      end
    end

    context 'with invalid params' do
      it 'redirects to the trips path if not chair representative' do
        trip = FactoryGirl.create(:trip, user: @user, status: 'applied')
        login_with(@user)
        post :hand_in, {id: trip.id}
        get :reject, {id: trip.to_param}, valid_session
        expect(response).to redirect_to(trips_path)
      end
    end
  end
end
