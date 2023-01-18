import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification"
export default class extends Controller {
  static target = ["notification-badge", "notification"]
  connect() {
    console.log(this.classList);
    if (this.element.classList.contains("bg-light-blue")){
      if (!this.notificationBadgeTaget.classList.contains("bg-light-blue")){

      }
    }
  }
}
