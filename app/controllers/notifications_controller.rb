class NotificationsController < ApplicationController
  before_action :set_object, only: [:destroy]

  def destroy
    respond_to do |format|
      if @notification.destroy!
        format.json { render json: { notification_id: @notification.id, status: 200, message: "Notification successfully removed!" } }
        # format.turbo_stream { render turbo_stream: turbo_stream.remove(@notification) }
      else
        format.json { render json: { notification_id: @notification.id, status: 403, message: "Notification failed to remove!" } }
        # flash.now[:alert] = "Notification failed to remove!"
        # format.turbo_stream { render turbo_stream: turbo_stream.prepend("flash", partial: "layouts/flash") }
      end
    end
  end

  private

    def set_object
      @notification = Notification.find(params[:notification_id])
    end
end
