# frozen_string_literal: true

class CreateExpensesUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses_users do |t|
      t.references :expense, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
