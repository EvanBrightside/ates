class Account < ApplicationRecord
  has_many :tasks, foreign_key: :account_id, dependent: :destroy
  has_many :auth_identities, foreign_key: :account_id, dependent: :destroy
  has_many :task_statuses, through: :tasks

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true

  # has_secure_password

  def self.from_omniauth(auth)
    find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |account|
      account.email = auth['info']['email']
      account.password = SecureRandom.hex
    end
  end

  def self.from_token_request(request)
    email = request.params['auth'] && request.params['auth']['email']
    find_by(email: email)
  end

  def self.from_token_payload(payload)
    find(payload['sub'])
  end

  def to_token_payload
    { sub: id }
  end
end
