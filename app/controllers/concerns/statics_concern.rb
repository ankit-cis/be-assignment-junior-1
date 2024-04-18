# frozen_string_literal: true

module StaticsConcern
  def update_bills
    @amount = params[:amount].to_i
    bills = current_user.bills.where(pay_to: params[:friend_id])
    update_bills_with_amount(bills)
    redirect_to root_path
  end

  def update_bills_with_amount(bills)
    bills.each do |bill|
      if bill.amount >= @amount && @amount.positive?
        update_bill_with_amount(bill)
      else
        while @amount.positive? && bill.amount < @amount
          @amount -= bill.amount
          bill.update(amount: 0, amount_paid: bill.amount)
        end
      end
    end
  end

  def update_bill_with_amount(bill)
    bill.update(amount: (bill.amount - @amount), amount_paid: @amount)
    @amount = 0
  end
end
