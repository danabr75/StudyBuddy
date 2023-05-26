import { Controller } from "@hotwired/stimulus"
console.log("decks_controller.js")

export default class extends Controller {
  static targets = ["deck"]

  connect() {
    this.element.addEventListener("ajax:success", this.handleSuccess)
  }

  disconnect() {
    this.element.removeEventListener("ajax:success", this.handleSuccess)
  }

  handleSuccess = (event) => {
    const [data, _status, xhr] = event.detail
    const comment = xhr.response

    this.commentTarget.insertAdjacentHTML("beforeend", comment)
  }
}