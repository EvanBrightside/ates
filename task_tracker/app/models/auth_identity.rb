class AuthIdentity < ApplicationRecord
  belongs_to :account

  validates :uid, presence: true
  validates :provider, presence: true
  validates :uid, uniqueness: { scope: :provider }

  def self.from_token_request(request)
    uid = request.params['auth_identity'] && request.params['auth_identity']['uid']
    find_by(uid: uid)
  end

  def self.from_token_payload(payload)
    find(payload['sub'])
  end

  def to_token_payload
    { sub: id }
  end
end
