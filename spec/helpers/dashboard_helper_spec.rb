require 'rails_helper'

RSpec.describe DashboardHelper, type: :helper do
  include Devise::Test::ControllerHelpers

  describe 'helper methods' do
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:user3) { FactoryBot.create(:user) }

    let(:expense1) { FactoryBot.create(:expense, amount: 200, created_by: user1.id) }
    let(:expense2) { FactoryBot.create(:expense, amount: 200, created_by: user1.id) }
    let(:expense3) { FactoryBot.create(:expense, amount: 200, created_by: user2.id) }

    before do
      sign_in user1
      FactoryBot.create(:bill, user: user2, expense: expense1, amount: 100, pay_to: user1.id)
      FactoryBot.create(:bill, user: user3, expense: expense2, amount: 100, pay_to: user1.id)
    end

    describe '#get_total_balance' do
      it 'returns the correct total balance' do
        expect(helper.get_total_balance([expense1, expense2])).to eq("+$200.0")
      end
    end

    describe '#friends_which_will_pay' do
      it 'returns users who will pay for expenses' do
        expenses = [expense1, expense2]
        expense1.users << user1
        expense1.users << user2
        expense1.users << user3

        expense2.users << user1
        expense2.users << user2
        expense2.users << user3

        expect(helper.friends_which_will_pay(expenses)).to match_array([user2, user3])
      end
    end

    describe '#amount_to_receive' do
      it 'calculates the amount to receive for a friend' do
        helper_amount = helper.amount_to_receive(user2, [expense1, expense2])
        expect(helper_amount).to eq(100)
      end
    end
    
    describe '#total_amount_to_receive' do
      it 'calculates the total amount to receive for the current user' do
        expect(helper.total_amount_to_receive([expense1, expense2], user1)).to eq(200)
      end
    end

    describe '#friends_you_owe' do
      it 'returns the IDs of friends you owe' do
        FactoryBot.create(:bill, user: user1, expense: expense1, amount: 100, pay_to: user2.id)
        FactoryBot.create(:bill, user: user1, expense: expense2, amount: 100, pay_to: user3.id)
        expect(helper.friends_you_owe).to match_array([user2.id, user3.id])
      end
    end

    describe '#friend_to_pay' do
      it 'returns the name of the friend to pay' do
        expect(helper.friend_to_pay(user2.id)).to eq(user2.name)
      end
    end

    describe '#friends_bill_amount' do
      it 'calculates the total bill amount for a friend' do
        FactoryBot.create(:bill, user: user1, expense: expense1, amount: 100, pay_to: user2.id)
        expect(helper.friends_bill_amount(user2.id)).to eq(100)
      end
    end

    describe '#amount_user_owe' do
      it 'returns the total amount the user owes' do
        total_amount_owe = user1.bills.pluck(:amount).sum
        expect(helper.amount_user_owe(user1)).to eq(total_amount_owe)
      end
    end

    describe '#friends_list' do
      it 'returns the list of friends excluding the current user' do
        expect(helper.friends_list).to match_array(User.where.not(id: user1.id))
      end
    end

    describe '#formatted_date' do
      it 'returns the formatted date' do
        expect(helper.formatted_date(expense1)).to eq(expense1.created_at.strftime('%b %d'))
      end
    end

    describe '#who_paid_for_expense' do
      it 'returns the correct string based on who paid for the expense' do
        expect(helper.who_paid_for_expense(expense2)).to eq('you paid')
        expect(helper.who_paid_for_expense(expense3)).to eq("#{user2.name} paid")
      end
    end

    describe '#you_lent_or_borrow' do
      let(:bill) { FactoryBot.create(:bill, user: user1, expense: expense1, amount: 100, pay_to: user2.id) }

      it 'returns correct message for borrow' do
        expect(helper.you_lent_or_borrow(bill)).to eq("you borrow #{user2.name}")
      end

      it 'returns correct message for lend' do
        bill.update(user: user2, pay_to: user1.id)
        expect(helper.you_lent_or_borrow(bill)).to eq("you lent #{user2.name}")
      end

      it 'returns correct message for no borrow or lend' do
        bill.update(user: user3)
        expect(helper.you_lent_or_borrow(bill)).to eq('No lent No borrow')
      end
    end

    describe '#lent_or_borrow_amount' do
      let(:bill1) { FactoryBot.create(:bill, user: user1, expense: expense1, amount: 100, pay_to: user2.id) }
      let(:bill2) { FactoryBot.create(:bill, user: user2, expense: expense2, amount: 150, pay_to: user1.id) }

      it 'returns amount for borrow or lend' do
        expect(helper.lent_or_borrow_amount(bill1, user2)).to eq("$#{bill1.amount}")
        expect(helper.lent_or_borrow_amount(bill2, user1)).to eq("$#{bill2.amount}")
      end

      it 'returns $0 if not borrowed or lent' do
        bill1.update(user: user3)
        expect(helper.lent_or_borrow_amount(bill1, user2)).to eq('$0')
      end
    end
  end
end
