# frozen_string_literal: true

class RemoveUserIdFromExpenses < ActiveRecord::Migration[6.1]
  def change
    remove_column :expenses, :user_id, :integer
    add_column :expenses, :created_by, :integer
  end
end
