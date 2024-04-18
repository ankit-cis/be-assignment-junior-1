# frozen_string_literal: true

class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.integer :amount
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
