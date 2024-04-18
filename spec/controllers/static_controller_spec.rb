# spec/controllers/static_controller_spec.rb

require 'rails_helper'

RSpec.describe StaticController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'GET #dashboard' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      before do
        sign_in user
      end

      it 'assigns @expenses' do
        get :dashboard
        expect(assigns(:expenses)).to eq(Expense.where(created_by: user.id))
      end

      it 'renders the dashboard template' do
        get :dashboard
        expect(response).to render_template(:dashboard)
      end
    end

    context 'when user is not signed in' do
      it 'redirects to the sign-in page' do
        get :dashboard
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #person' do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }

    before do
      sign_in user
    end

    it 'assigns @person and @expenses' do
      get :person, params: { id: other_user.id }
      expect(assigns(:person)).to eq(other_user)
      expect(assigns(:expenses)).to eq(other_user.expenses)
    end

    it 'renders the person template' do
      get :person, params: { id: other_user.id }
      expect(response).to render_template(:person)
    end
  end
end
