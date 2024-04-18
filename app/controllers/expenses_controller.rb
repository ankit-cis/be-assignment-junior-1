# frozen_string_literal: true

class ExpensesController < ApplicationController
  include ExpensesConcern

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      add_friends_for_expense
      create_bills_for_friends
    end
    redirect_to root_path
  end

  private

  def expense_params
    params.require(:expense).permit(:amount, :description, :created_by)
  end
end
