class Task < ApplicationRecord
  has_many :task_statuses, foreign_key: :task_id, dependent: :destroy
  belongs_to :account

  enum status: { created: 0, done: 1 }

  validates :title, presence: true
  validates :status, presence: true
  validates :status, inclusion: { in: statuses.keys }

  def self.from_token_request(request)
    title = request.params['task'] && request.params['task']['title']
    find_by(title: title)
  end

  def self.from_token_payload(payload)
    find(payload['sub'])
  end

  def to_token_payload
    { sub: id }
  end
end
