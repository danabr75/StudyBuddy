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

// TODO: Why using function doesn't work but variable function does 
// Flips card view (front/back)
window.studyCardFlip = function(button) {
  
  // TODO: Look into scoping w/ js (let vs var vs const)
  var card = $(".study-card.active")
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


//TODO: Create helper for methods below getting verified card
// Records the result (Correct/Incorrect) of a card
window.studyCardRecordResult = function(result) {
  var card = $(".study-card.active")
  if (card == undefined) {
    alert("Card not found.")
    return false
  }
  if (card.length != undefined && card.length > 1) {
    alert("Too many cards.")
    return false
  }

  // 
  console.log('recorded, result is: ' + result)
  return true
}

// A $( document ).ready() block.
$( document ).ready(function() {
    console.log( "ready!" );
});


var myCarousel = document.getElementById('carouselExampleIndicators')


myCarousel.addEventListener('slide.bs.carousel', function () {
  console.log("slide change")
  var card = $(".study-card.active")
  if (card == undefined) {
    alert("Card not found.")
    return false
  }
  if (card.length != undefined && card.length > 1) {
    alert("Too many cards.")
    return false
  }
  var card_id = card.data('id')
  console.log("card id is: " + card_id)
  console.log(card)
  //locate pre-existing correct input for card result
  var correct_input = $("#cardResultForm" + card_id + " input[type=checkbox]")
  console.log("correct_input")
  console.log(correct_input)
  console.log(correct_input.val())
  console.log(correct_input.checked)
})

console.log("end of javascript logic")