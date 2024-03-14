# frozen_string_literal: true

class Wallet < ApplicationRecord
  belongs_to :account

  validates :balance, presence: true
  validates :currency, presence: true

  def deposit(amount)
    update(balance: balance + amount)
  end

  def withdrawal(amount)
    update(balance: balance - amount)
  end

  def transfer(amount, to_wallet)
    withdrawal(amount)
    to_wallet.deposit(amount)
  end

  def account
    Account.find(account_id) if account_id != nil
  end
end
