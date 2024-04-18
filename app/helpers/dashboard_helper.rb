# frozen_string_literal: true

module DashboardHelper
  def get_total_balance(expenses)
    amount_owed = total_amount_to_receive(expenses, current_user)
    amount_owe = amount_user_owe(current_user)
    amount = (amount_owed - amount_owe).abs
    amount_owed > amount_owe ? "+$#{amount}" : "$#{amount}"
  end

  def friends_which_will_pay(expenses)
    friends = []
    expenses.each do |expense|
      friends_in_expense = expense.users.where.not(id: current_user.id).pluck(:id)
      friends += friends_in_expense
    end
    User.where(id: friends.uniq)
  end

  def amount_to_receive(friend, expenses)
    expense_ids = expenses.pluck(:id)
    amount = friend.bills.where(expense_id: expense_ids).pluck(:amount)
    amount.sum
  end

  def total_amount_to_receive(expenses, _user)
    amount = []
    expenses.each do |expense|
      amount << expense.bills.pluck(:amount).sum
    end
    amount.sum
  end

  def friends_you_owe
    current_user.bills.pluck(:pay_to).uniq
  end

  def friend_to_pay(friend_id)
    User.find_by(id: friend_id).name
  end

  def friends_bill_amount(friend_id)
    current_user.bills.where(pay_to: friend_id).pluck(:amount).sum
  end

  def amount_user_owe(user)
    user.bills.pluck(:amount).sum
  end

  def friends_list
    User.where.not(id: current_user.id)
  end

  def formatted_date(expense)
    expense.created_at.strftime('%b %d')
  end

  def who_paid_for_expense(expense)
    if expense.created_by == current_user.id
      'you paid'
    else
      name = User.find_by(id: expense.created_by).name
      "#{name} paid"
    end
  end

  def you_lent_or_borrow(bill)
    if bill.user_id == current_user.id
      friend = User.find_by(id: bill.pay_to)
      "you borrow #{friend.name}"
    elsif bill.pay_to == current_user.id
      friend = User.find_by(id: bill.user_id)
      "you lent #{friend.name}"
    else
      'No lent No borrow'
    end
  end

  def lent_or_borrow_amount(bill, _friend)
    if bill.user_id == current_user.id || bill.pay_to == current_user.id
      "$#{bill.amount}"
    else
      '$0'
    end
  end
end
