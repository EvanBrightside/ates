# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :task
  belongs_to :account
  belongs_to :wallet

  validates :amount, presence: true
  validates :currency, presence: true
  validates :type, presence: true

  enum type: %i[deposit withdrawal]

  after_create :update_wallet_balance

  private

  def update_wallet_balance
    if deposit?
      wallet.deposit(amount)
    else
      wallet.withdrawal(amount)
    end
  end

  def wallet
    account.wallet
  end

  def account
    task.account
  end

  def deposit?
    type == 'deposit'
  end

  def withdrawal?
    type == 'withdrawal'
  end

  def task
    Task.find(task_id) if task_id != nil
  end

  def account
    Account.find(account_id) if account_id != nil
  end

  def wallet
    Wallet.find(wallet_id) if wallet_id != nil
  end
end
