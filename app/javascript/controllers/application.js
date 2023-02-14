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

//Verifies that we got the expected card object
window.getVerifiedCard = function() {
  var card = $(".study-card.active")
  if (card == undefined) {
    alert("Card not found.")
    return null
  }
  if (card.length != undefined && card.length > 1) {
    alert("Too many cards.")
    return null
  }

  console.log("~~~card: " + card.data('id'))
  return card
}

// TODO: Why using function doesn't work but variable function does 
// Flips card view (front/back)
window.studyCardFlip = function(button) {
  
  // TODO: Look into scoping w/ js (let vs var vs const)
  var card = getVerifiedCard()
  if (card == null){
    return false
  }

  var visible_part = card.find(".card:not(.visually-hidden)")
  var invisible_part = card.find(".card.visually-hidden")
  visible_part.addClass("visually-hidden")
  invisible_part.removeClass("visually-hidden")
  console.log('flipped')
  return true
}

//var lastRadioResult = null;


// Records the result (Correct/Incorrect) of a card
// Returns true, false, undefined (neither correct/incorrect was set)
window.studyCardRecordResult = function(result) {

  if ($("#score_corr").prop("checked") == true) {
    return true
  } else if ($("#score_incorr").prop("checked") == true) {
    return false
  } else {
    return undefined
  }

  // var card = getVerifiedCard()
  // if (card == null){
  //   return false
  // }

  // // 
  // console.log('recorded, result is: ' + result.value)
  // lastRadioResult = result.value;
}

// A $( document ).ready() block.
$( document ).ready(function() {
    console.log( "ready!" );
});


var myCarousel = document.getElementById('carouselExampleIndicators')

myCarousel.addEventListener('slide.bs.carousel', function () {
  console.log("slide change")
  //Previous Card
  var card = getVerifiedCard()
  if (card == null) {
    console.log("card is invalid")
  }

  var card_id = card.data('id')
  console.log("cardId: " + card_id)

  var formRef = $("#cardResultForm" + card_id)
  console.log("formRef:")
  console.log(formRef)


  // After you slide the carousel, it writes to the form of the last card w/ the last selected radio value
  var hidden_form_card_result = $("#cardResultForm" + card_id + " input[type=checkbox]")
// window.studyCardRecordResult = function(result) {
  
  var cardRecordResult = studyCardRecordResult();
  console.log(cardRecordResult)

  if (cardRecordResult == true){
    hidden_form_card_result.prop( "checked", true); //assign
    hidden_form_card_result.data("has-value-been-set", "true");
  } else if (cardRecordResult == false){
    hidden_form_card_result.prop( "checked", false);
    hidden_form_card_result.data("has-value-been-set", "true");
  } else {
    hidden_form_card_result.prop( "checked", undefined);
  }


  // Prints the results of the last card
  if (hidden_form_card_result.prop("checked") == true) {
    console.log("~ card_id " + card_id + " is CHECKED")
  } else if (hidden_form_card_result.prop("checked") == false){
    console.log("~ card_id " + card_id + " is UNCHECKED")
  } else {
    console.log("ERROR - Could not find correct input")
  }

})

myCarousel.addEventListener('slid.bs.carousel', function () {
  console.log("slid change")
  var card = getVerifiedCard()
  if (card == null) {
    console.log("card is invalid")
  }

  var card_id = card.data('id')
  console.log("cardId: " + card_id)

  var hidden_form_card_result = $("#cardResultForm" + card_id + " input[type=checkbox]")

  var correct_radio = $("#score_corr")
  var incorrect_radio = $("#score_incorr")

  if (hidden_form_card_result.prop("checked") == true && hidden_form_card_result.data("has-value-been-set") == "true") {
    console.log("Form Checkbox - Checked True")
    correct_radio.prop("checked", true)
    incorrect_radio.prop("checked", false)
  } else if (hidden_form_card_result.prop("checked") == false && hidden_form_card_result.data("has-value-been-set") == "true"){
    console.log("Form Checkbox - Checked False")
    correct_radio.prop("checked", false)
    incorrect_radio.prop("checked", true)
  } else {
    console.log("Form Checkbox - Checked N/A")
    correct_radio.prop("checked", false)
    incorrect_radio.prop("checked", false)
  }


})

$( "#card_results_form" ).submit(function( event ) {
  // TODO - .) Move study page code to .js file
  // TODO - 1.) Call slid/slide events as functions before submitting
  // (radio button selections aren't submitted to the form until carousel triggers the
  // slide event, may also be appropriate on slid event)
  // TODO - 2.) Routing error on submit
  // TODO - 3.) Make form invisible
  // TODO - 4.) Prompt for unsaved data if any rerouting is attempted on study page
  // TODO - 5.) Prompt for unsaved data if any closing is attempted on study page
  alert( "Handler for .submit() called." );
  // event.preventDefault();
});

console.log("end of javascript logic")