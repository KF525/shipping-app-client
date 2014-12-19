class Order < ActiveRecord::Base
  has_many :items, class_name: "LineItem"
  has_one :address
  has_one :credit_card
  validates :number, uniqueness: true
  before_create :set_number

  def total
    product_cost = Money.new items.sum(:total_cents)
    if self.address && self.shipping_service
       product_cost + Money.new(Shipping.shipping_cost(self.address, product_weight, self.shipping_service))
    else
       product_cost
    end
  end

  def product_weight
    self.items.inject(0) { |sum, item| sum + item.product.weight }
  end

  private

  def set_number
    while !self.number || Order.exists?(number: self.number.to_s)
      self.number = create_number
    end
  end

  def create_number
    (SecureRandom.random_number(9000000) + 1000000).to_s
  end

end
