console.log("start of javascript logic")
// TODO: figure out why jquery had to be imported here, not importing in proper order from other application.js file w/ imports
import "jquery"
import "jquery_ujs"

import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

console.log("end of javascript logic")