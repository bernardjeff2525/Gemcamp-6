class Order < ApplicationRecord
  include AASM

  belongs_to :user

  after_create :assign_serial_number

  aasm column: :state do
    state :pending, initial: true
    state :submitted, :paid, :failed, :revoked, :delivered

    event :submit do
      transitions from: :pending, to: :submitted
    end

    event :pay do
      transitions from: :submitted, to: :paid
    end

    event :fail do
      transitions from: :pending, to: :failed
      transitions from: :submitted, to: :failed
    end

    event :revoke do
      transitions from: [:pending, :submitted], to: :revoked
      transitions from: [:delivered], to: :revoked

    end

    event :deliver do
      transitions from: :paid, to: :delivered
    end
  end

  private

  def assign_serial_number
    self.update(serial_number: "gem-#{id.to_s.rjust(9, '0')}")
  end


  # Create atleast 100 orders random users
  # Orders
  #
end
