# To deliver this notification:
#
# BidNotification.with(post: @post).deliver_later(current_user)
# BidNotification.with(post: @post).deliver(current_user)

class BidNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"
  
  after_database :update_realtime
  
  # Add required params
  #
  param :bid

  # Define helper methods to make rendering easier.
  #
  def message
    params[:bid].name
  end
  #
  def url
    bid_path(params[:bid])
  end

  def update_realtime
    
    params[:bid].broadcast_notification(self.recipient)
    
  end
end