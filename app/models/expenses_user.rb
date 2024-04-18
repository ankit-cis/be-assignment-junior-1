# frozen_string_literal: true

class ExpensesUser < ApplicationRecord
  belongs_to :user
  belongs_to :expense
end
