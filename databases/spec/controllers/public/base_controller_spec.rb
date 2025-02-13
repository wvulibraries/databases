require 'rails_helper'

describe Public::BaseController, type: :controller do
  let(:user) { FactoryBot.create :user }

  describe '.client_ip' do
    it 'to return the ip of the client' do
      expect(controller.client_ip).to eq(request.remote_ip)
    end

    it 'expects it to set it as a global variable' do
      get :index
      expect(assigns(:client_ip)).to be_a(IPAddr)
    end
  end

  context 'authentication' do
    describe '.authenticated?' do
      it 'should return true and be authenticated' do
        get :index, session: { 'cas' => { 'user' => user.cas_username } }
        expect(controller.authenticated?).to be true
      end

      it 'should return false and be unauthenticated' do
        get :index, session: nil
        expect(controller.authenticated?).to be false
      end
    end

    describe '.access_permissions' do
      it 'should return true because the user is an admin and is logged in' do
        get :index, session: { 'cas' => { 'user' => user.cas_username } }
        expect(controller.access_permissions).to be true
      end
    end

    describe '.admin?' do
      it 'should return false because no user is authenticated' do
        get :index, session: nil
        expect(controller.admin?).to be false
      end

      it 'should return true because the user exists and is authenticated' do
        get :index, session: { 'cas' => { 'user' => user.cas_username } }
        expect(controller.admin?).to be true
      end
    end

    describe '.current_user' do
      it 'should return false' do
        get :index, session: nil
        expect(controller.current_user).to be false
      end 

      it 'should return the user object' do
        get :index, session: { 'cas' => { 'user' => user.cas_username } }
        expect(controller.current_user).to be_a(User)
      end
    end

    describe '.access_feedback' do
      it 'should return a string' do
        get :index, session:  nil
        str = I18n.t('auth.invalid_access') << I18n.t('auth.invalid_permissions')
        expect(controller.access_feedback).to be_a(String)
        expect(controller.access_feedback).to eq(str)
      end

      it 'should return a string for authenticated, but not admin' do
        get :index, session: { 'cas' => { 'user' => 'randyapplegate' } }
        expect(controller.access_feedback).to eq(I18n.t('auth.invalid_permissions'))
      end

      it 'should return a empty string good auth and admin' do
        get :index, session: { 'cas' => { 'user' => user.cas_username } }
        expect(controller.access_feedback).to eq('')
      end
    end
  end
end
