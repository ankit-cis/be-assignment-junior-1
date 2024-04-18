# frozen_string_literal: true

class StaticController < ApplicationController
  include StaticsConcern
  before_action :new_expense, only: %i[dashboard person]

  def dashboard
    @expenses = Expense.where(created_by: current_user.id)
  end

  def person
    @person = User.find_by(id: params[:id])
    @expenses = @person.expenses
  end

  def add_friend
    render partial: 'add_friend_form'
  end

  private

  def new_expense
    @expense = Expense.new
  end
end
