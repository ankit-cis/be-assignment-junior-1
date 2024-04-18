class UpdateDataTypeForAmount < ActiveRecord::Migration[6.1]
  def change
    change_column :bills, :amount, :decimal, precision: 10, scale: 2
    change_column :bills, :amount_paid, :decimal, precision: 10, scale: 2
    change_column :expenses, :amount, :decimal, precision: 10, scale: 2
  end
end
