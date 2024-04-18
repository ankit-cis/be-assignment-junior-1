# frozen_string_literal: true

class CreateBills < ActiveRecord::Migration[6.1]
  def change
    create_table :bills do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :amount
      t.references :expense, null: false, foreign_key: true
      t.boolean :paid, default: false
      t.integer :pay_to

      t.timestamps
    end
  end
end
