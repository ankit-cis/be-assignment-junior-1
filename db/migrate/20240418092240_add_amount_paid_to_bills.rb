# frozen_string_literal: true

class AddAmountPaidToBills < ActiveRecord::Migration[6.1]
  def change
    add_column :bills, :amount_paid, :integer
  end
end
