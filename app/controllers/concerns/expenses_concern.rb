# frozen_string_literal: true

module ExpensesConcern
  def add_friends_for_expense
    @expense.users << current_user
    params[:expense][:friends].each do |friend|
      @expense.users << User.find_by(id: friend[:friend_id])
    end
  end

  def create_bills_for_friends
    equal_amount = @expense.amount / @expense.users.count
    friends = @expense.users.where.not(id: current_user.id)
    friends.each do |friend|
      Bill.create(user_id: friend.id, amount: equal_amount, expense_id: @expense.id, pay_to: @expense.created_by)
    end
  end
end
