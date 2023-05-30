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

$(document).ready(function() {
  $(document).on("card_result_selected", ".deck-row", function(event) {
    haveAllCardResultsBeenCompleted();
  });

  $(document).on("click", ".deck-row", function(event) {
    var nodeName = event.target.nodeName;
    console.log("Clicked element's nodeName: " + nodeName);
    if (nodeName === "BUTTON" || nodeName === "A" || nodeName === "INPUT") {
      return;
    } else {
      // Event triggered only when the background of the row is clicked,
      // excluding clicks on buttons within the row.
      $(this).closest('.deck-row').siblings('.deck-row').removeClass('active');
      $(this).closest('.deck-row').toggleClass('active')
    }
  });
});
