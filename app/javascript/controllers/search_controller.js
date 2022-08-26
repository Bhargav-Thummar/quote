import { Controller } from "@hotwired/stimulus"
import _debounce, { debounce } from "debounce"


// Connects to data-controller="search"
export default class extends Controller {
  initialize(){
    this.submit = debounce(this.submit.bind(this), 500);
  }

  submit(){
    this.element.requestSubmit();
  }
}
