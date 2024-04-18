# frozen_string_literal: true

class Expense < ApplicationRecord
  has_many :expenses_users, dependent: :destroy
  has_many :users, through: :expenses_users
  has_many :bills, dependent: :destroy

  validates :amount, presence: true
end
