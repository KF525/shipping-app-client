class CreditCard < ActiveRecord::Base
  validates :name, :number, :expiration, presence: true
end
