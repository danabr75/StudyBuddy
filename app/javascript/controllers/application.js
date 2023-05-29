// TODO: figure out why jquery had to be imported here, not importing in proper order from other application.js file w/ imports
import "jquery"
import "jquery_ujs"

import { Application } from "@hotwired/stimulus";

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

import { Controller } from "@hotwired/stimulus";

window.createAlert = function(alertType, message, removalTime = 3000) {
  var validAlertTypes = ['primary', 'secondary', 'success', 'danger', 'warning', 'info', 'light', 'dark'];

  // Validate the alert type.
  if (!validAlertTypes.includes(alertType)) {
    console.error('Invalid alert type. Valid types are: primary, secondary, success, danger, warning, info, light, dark');
    return;
  }

  var alertElement = $(
    '<div class="alert alert-' + alertType + ' alert-dismissible fade show" role="alert">' +
      message +
      '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>' +
    '</div>'
  );

  $('#pinnedToScreenAlertContainer').append(alertElement);

  // Remove the alert after the specified time.
  setTimeout(function() {
    $(alertElement).fadeTo(500, 0).slideUp(500, function() {
      $(this).remove();
    });
  }, removalTime);
}
