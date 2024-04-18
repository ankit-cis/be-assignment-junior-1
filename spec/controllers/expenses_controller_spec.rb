# spec/controllers/expenses_controller_spec.rb

require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'POST #create' do
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:valid_params) { { expense: { amount: 100, description: 'Test Expense', created_by: 'Test User', friends: [{'friend_id'=>user2.id}] } } }

    before do
      sign_in user1
    end

    context 'with valid parameters' do
      it 'creates a new expense' do
        expect {
          post :create, params: valid_params
        }.to change(Expense, :count).by(1)
      end

      it 'redirects to the root path' do
        post :create, params: valid_params
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        { expense: { amount: nil, description: 'Test Expense', created_by: 'Test User', friends: [{ 'friend_id' => user2.id }] } }
      end

      it 'does not create a new expense' do
        expect {
          post :create, params: invalid_params
        }.not_to change(Expense, :count)
      end
    end
  end
end
