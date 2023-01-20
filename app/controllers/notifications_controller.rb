class NotificationsController < ApplicationController
  before_action :set_object, only: [:destroy]

  def destroy
    if @notification.destroy!
      render json: { notification_id: @notification.id, status: 200, message: "Notification successfully removed!" }
    else
      render json: { notification_id: @notification.id, status: 403, message: "Notification failed to remove!" }
    end
  end

  private

    def set_object
      @notification = Notification.find(params[:notification_id])
    end
end
