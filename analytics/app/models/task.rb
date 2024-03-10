# frozen_string_literal: true

class Task < ApplicationRecord

  belongs_to :account
  has_many :payments

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true

  enum status: %i[in_progress completed]

  after_create :create_payments

  private

  def create_payments
    payment_type = self.status == 'completed' ? 'deposit' : 'withdrawal'
    Payment.create(
      task: self,
      account: account,
      wallet: account.wallet,
      amount: 0,
      currency: account.wallet.currency,
      type: payment_type
    )
  end

  def account
    Account.find(account_id) if account_id != nil
  end

  def payments
    Payment.where(task_id: id)
  end
end