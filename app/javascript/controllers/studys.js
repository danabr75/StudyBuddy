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
}

// A $( document ).ready() block.
$( document ).ready(function() {
    console.log( "ready!" );
});


var myCarousel = document.getElementById('carouselExampleIndicators')

// When the user navigates to another card, store the score values for the last card in a form.
myCarousel.addEventListener('slide.bs.carousel', function () {
  console.log("slide change")
  slideFnc()
})

// When a user navigates to a new card, get the last chosen results of the current card from the
// form if they exist and update the radio buttons.
myCarousel.addEventListener('slid.bs.carousel', function () {
  console.log("slid change")

  // Reference to the card
  var card = getVerifiedCard()
  if (card == null) {
    console.log("card is invalid")
  }

  // Reference to the card's id
  var card_id = card.data('id')
  console.log("cardId: " + card_id)

  // Reference to the appropriate checkbox on the form for a card
  var hidden_form_card_result = $("#cardResultForm" + card_id + " input[type=checkbox]")
  
  // Reference to the radio buttons
  var correct_radio = $("#score_corr")
  var incorrect_radio = $("#score_incorr")

  // Retrieve the last selected results of the radio buttons for the current card and set the
  // radio buttons
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

window.slideFnc = function() {
  // Reference to the card
  var card = getVerifiedCard()
  if (card == null) {
    console.log("card is invalid")
  }

  // Reference to the card's ID
  var card_id = card.data('id')

  // Reference to appropriate checkbox (of last card).
  var hidden_form_card_result = $("#cardResultForm" + card_id + " input[type=checkbox]")
  
  //Gets the last radio button selection (Correct/Incorrect/Neither)
  var cardRecordResult = studyCardRecordResult();
  console.log(cardRecordResult)

  // Writes values to form and indicates a choice has been made on checkbox.
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

  console.log("slideFnc Ran!!!")
}

$( "#card_results_form" ).submit(function( event ) {
  // Calls slideFnc before submitting to store most recent results (radio button selections aren't
  // submitted to the form until carousel triggers the slide event)
  slideFnc();

  // TODO - 1.) Fix Loading Bug (loading in on page works, but weird cycling lag from other pages)
  // TODO - 2.) Routing error on submit
  // TODO - 3.) Prompt for unsaved data if any rerouting is attempted on study page
  // TODO - 4.) Prompt for unsaved data if any closing is attempted on study page

  alert( "Handler for .submit() called." );
  // event.preventDefault();
});