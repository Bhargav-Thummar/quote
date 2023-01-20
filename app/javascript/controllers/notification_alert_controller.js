import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification-alert"
export default class extends Controller {
  static targets = [ "individualNotification", "alertNotificationBadge" ]
  alertVisibility = false

  // on controller initialize
  connect() {
    // this.displayNotificationAlertBedge();
  }

  // on new notification DOM connect
  individualNotificationTargetConnected(element) {
    if (!this.alertVisibility) {
      this.displayNotificationAlertBedge();
    }
  }

  // on individual notification DOM disconnect/removal
  individualNotificationTargetDisconnected(element) {
    this.displayNotificationAlertBedge();
  }

  // to send ajax for deletion of notification
  removeNotification(event) {
    this.notificationId = event.target.parentElement.parentElement.dataset['notificationId'];

    fetch("/notifications/" + this.notificationId, {
      method: 'DELETE',
      headers: {
        "X-CSRF-Token": this.getMetaValue("csrf-token")
      },
    }).then(response => {
      if(response.ok) {
        return response.json()
      } else {
        return Promise.reject(response)
      }

    }).then(data => {
      if (data["status"] == 200) {
        document.querySelector(`[data-notification-id="${data['notification_id'].toString()}"]`).remove();
      } else {
        alert("Something went wrong!")     
      }

    }).catch( error => {
      console.warn(error)
    });
  }

  // manage visibility of notification alert bedge on bell icon
  displayNotificationAlertBedge() {
    if ( this.hasUnreadNotifications() ){
      this.alertNotificationBadgeTarget.classList.remove("visually-hidden");
    } else {
      this.alertNotificationBadgeTarget.classList.add("visually-hidden");
    }
  }

  // to any unread notification exist
  hasUnreadNotifications() {
    this.alertVisibility = this.individualNotificationTargets.length > 0
    return this.alertVisibility
  }

  // to get attribute values of meta tag
  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element.getAttribute("content")
  }
}
