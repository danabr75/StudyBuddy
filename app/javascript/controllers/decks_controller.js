import { Controller } from "@hotwired/stimulus"
import { Turbo } from '@hotwired/turbo-rails';

export default class extends Controller {
  connect() {
    console.log("Deck controller connected")
  }

  update(event) {
    // Handle the Turbo Stream update here
  }

}