class TaskStatus < ApplicationRecord
  belongs_to :task
  belongs_to :account

  enum status: { created: 0, done: 1 }

  validates :status, presence: true
  validates :status, inclusion: { in: statuses.keys }

  def self.from_token_request(request)
    status = request.params['task_status'] && request.params['task_status']['status']
    find_by(status: status)
  end

  def self.from_token_payload(payload)
    find(payload['sub'])
  end

  def to_token_payload
    { sub: id }
  end
end
