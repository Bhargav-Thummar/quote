class Bid < ApplicationRecord
  has_noticed_notifications

  has_many :line_item_dates, dependent: :destroy
  has_many :line_items, through: :line_item_dates
  
  belongs_to :company
  has_many :users, through: :company
  
  validates :name, presence: true
  
  scope :ordered, -> { order(id: :desc) }

  # after_create_commit -> { broadcast_prepend_to "bids", partial: "bids/bid", locals: { bid: self }, target: "bids" }

  # As we can see above, we specify the target name to be "bids" thanks to the target: "bids" option. By default, the target option will be equal to model_name.plural, which is equal to "bids" in the context of our Bid model. Thanks to this convention, we can remove the target: "bids" option:
  # The partial default value is equal to calling to_partial_path on an instance of the model, which by default in Rails for our Bid model is equal to "bids/bid".
  # The locals default value is equal to { model_name.element.to_sym => self } which, in in the context of our Bid model, is equal to { bid: self }.

  # after_create_commit -> { broadcast_prepend_later_to "bids" }
  # after_update_commit -> { broadcast_replace_later_to "bids" }
  # after_destroy_commit -> { broadcast_remove_to "bids" }


  # short hand for the above three line

  broadcasts_to ->(bid) { [bid.company, "bids"] }, inserts_by: :prepend

  after_create_commit :notify_user
  
  def notify_user
    BidNotification.with(bid: self).deliver_later(users)
  end

  def broadcast_notification(user)
    
    broadcast_prepend_later_to(
      user,
      company,
      :notifications,
      target: 'notifications-list',
      partial: 'notifications/notification',
      locals: {
        notification: self.notifications_as_bid.first
      }
    )
  end

  def total_price
    line_items.sum(&:total_price)
  end
  
end
