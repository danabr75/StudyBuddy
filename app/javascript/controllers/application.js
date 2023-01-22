import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

// TODO: Why using function doesn't work but variable function does 
window.studyCardFlip = function(button) {
  
  // TODO: Look into scoping w/ js
  var card = $(".study-card")
  if (card == undefined) {
    alert("Card not found.")
    return false
  }
  if (card.length != undefined && card.length > 1) {
    alert("Too many cards.")
    return false
  }

  var visible_part = card.find(".card:not(.visually-hidden)")
  var invisible_part = card.find(".card.visually-hidden")
  visible_part.addClass("visually-hidden")
  invisible_part.removeClass("visually-hidden")
  console.log('flipped')
  return true
}