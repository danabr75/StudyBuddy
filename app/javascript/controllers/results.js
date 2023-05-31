// TODO: figure out why jquery had to be imported here, not importing in proper order from other application.js file w/ imports
const CORRECT_CARD_RESULT_RADIO_INPUT_SELECTOR = "#score_corr";
const INCORRECT_CARD_RESULT_RADIO_INPUT_SELECTOR = "#score_incorr";

/**
 * Retrieve the active study card from the DOM.
 * @returns {Object|null} - jQuery object representing the card if found and valid, otherwise null.
 */
window.getVerifiedCard = function() {
  const card = $(".study-card.active");
  if (!card || card.length > 1) {
    const message = !card ? "Card not found." : "Too many cards.";
    alert(message);
    return null;
  }
  // console.log("~~~card: " + card.data('id'));
  return card;
};

/**
 * Flip the card view from front to back or back to front.
 * @returns {boolean} - Returns false if card is not found, otherwise true.
 */
window.studyCardFlip = function() {
  $('.flipper').toggleClass('flipped');
  // .card-front will have 'flipped-over' class if no longer 'on top'
  // - will let us know to reset it before we carousel-navigate elsewhere.
  $('.carousel-item.active .card-front').toggleClass('flipped-over');
  console.log('flipped');
};
window.resetCardFlip = function() {
  if ($('.carousel-item.active .card-front').hasClass('flipped-over')) {
    // console.log("Card was flipped, resetting")
    studyCardFlip();
  }
};
/**
 * Disable the 'next' button, next to the guess button, until an answer has been selected
 */
window.disableNextButton = function() {
  $('#next').attr('disabled', 'disabled');
};
/**
 * Enable the 'next' button, next to the guess button, when an answer has been selected
 */
window.enableNextButton = function() {
  $('#next').removeAttr('disabled');
};

/**
 * Record the result (Correct/Incorrect) of a card.
 * @returns {boolean|undefined} - Returns true if correct, false if incorrect, otherwise undefined.
 */
window.studyCardRecordResult = function() {
  if ($(CORRECT_CARD_RESULT_RADIO_INPUT_SELECTOR).prop("checked")) {
    return true;
  } else if ($(INCORRECT_CARD_RESULT_RADIO_INPUT_SELECTOR).prop("checked")) {
    return false;
  } else {
    return undefined;
  }
};

/**
 * Colorizes the carousel indicators (horizontal bars under the cards), based on correctness.
 * Triggers a "score_selected" event.
 */
window.cardResultSelected = function(){
  const card = getVerifiedCard();
  const card_id = card.data('id');
  const carousel_indicators_element = $("[data-card-id='" + card_id + "']");
  
  // Reset CSS for indicator.
  carousel_indicators_element.removeClass('bg-danger').removeClass('bg-success');
  
  const indicator_class = $(INCORRECT_CARD_RESULT_RADIO_INPUT_SELECTOR).prop('checked') ? 'bg-danger' : 'bg-success';
  carousel_indicators_element.addClass(indicator_class);

  saveCardResultToHTMLForm();

  $("body").trigger("card_result_selected");
};

window.setFocusToGuessInput = function(){
  $('#guess').focus();
}

/**
 * Pulls the word count from the active card and replaces the placeholder in the guess input
 */
window.setGuessInputPlaceHolder = function() {
  const card = getVerifiedCard();
  const word_count = card.data('word-count');
  var translations_placeholder_suffix;
  if (parseInt(word_count) === 1) {
    translations_placeholder_suffix = $('#translations_guess_placeholder_suffix_singular').val();
  } else {
    translations_placeholder_suffix = $('#translations_guess_placeholder_suffix_plural').val();
  }
  $('#guess').attr('placeholder', word_count + translations_placeholder_suffix);
}
window.clearGuessInputPlaceHolder = function() {
  $('#guess').attr('placeholder', '');
}

/**
 * Pulls data from the cardResultForm to check the corresponding correct/incorrect radio input.
 */
window.populateGuessFormWithCardResultForm = function() {
  console.log("slid change");
  // Trying to reset here as a safety, sometimes the caurosel doesn't clear it in time.
  resetCardFlip();
  $(".loading-disable").removeClass('loading-disabled');
  // $(".card-result-radio").button('reset');
  const card = getVerifiedCard();
  if (card === null) {
    return;
  }
  const card_id = card.data('id');

  const hidden_form_card_result = $("#cardResultForm" + card_id + " input[type=checkbox]");
  const correct_radio = $(CORRECT_CARD_RESULT_RADIO_INPUT_SELECTOR);
  const incorrect_radio = $(INCORRECT_CARD_RESULT_RADIO_INPUT_SELECTOR);

  if (hidden_form_card_result.prop("checked") && hidden_form_card_result.data("has-value-been-set") === "true") {
    correct_radio.prop("checked", true);
    incorrect_radio.prop("checked", false);
  } else if (!hidden_form_card_result.prop("checked") && hidden_form_card_result.data("has-value-been-set") === "true"){
    correct_radio.prop("checked", false);
    incorrect_radio.prop("checked", true);
  } else {
    correct_radio.prop("checked", false);
    incorrect_radio.prop("checked", false);
  }

  if (hidden_form_card_result.data("has-value-been-set") === "true") {
    // Already filled out, re-enable the next button
    enableNextButton();
  }
};

/**
 * Occurs BEFORE the slide
 * Resets the buttons/checkboxes UI
 */
window.resetGuessForm = function() {
  $(".loading-disable").addClass('loading-disabled');
  $("input#guess").val('');
  $(CORRECT_CARD_RESULT_RADIO_INPUT_SELECTOR).prop("checked", false);
  $(INCORRECT_CARD_RESULT_RADIO_INPUT_SELECTOR).prop("checked", false);
}

/**
 * Saves the correct/incorrect radio selection to the hidden cardResultForm
 */
window.saveCardResultToHTMLForm = function() {
  const card = getVerifiedCard();
  if (card === null) {
    console.log("card is invalid");
    return;
  }
  const card_id = card.data('id');
  const hidden_form_card_result = $("#cardResultForm" + card_id + " input[type=checkbox]");
  const card_record_result = studyCardRecordResult();

  hidden_form_card_result.prop( "checked", card_record_result !== undefined ? card_record_result : undefined);
  hidden_form_card_result.data("has-value-been-set", card_record_result !== undefined ? "true" : "false");

  if (hidden_form_card_result.prop("checked")) {
    console.log("~ card_id " + card_id + " is CHECKED");
  } else if (hidden_form_card_result.prop("checked") === false){
    console.log("~ card_id " + card_id + " is UNCHECKED");
  } else {
    console.log("ERROR - Could not find correct input");
  }
};

/**
 * Handle the guess answer form submission event.
 * Intercepts the guess_answer form, and converts it into async process.
 * Checks the appropriate card cards 
 */
$(document).on('submit', '#guess_answer', function(event) {
  event.preventDefault();
  $(".loading-disable").addClass('loading-disabled');
  const card = getVerifiedCard();
  const card_id = card.data('id');
  $("input[name='card_id']").val(card_id);
  
  $.ajax({
    url: '/cards/guess',
    method: 'POST',
    data: $(this).serialize(),
    success: function(response) { 
      const radio_input = response.success ? $(CORRECT_CARD_RESULT_RADIO_INPUT_SELECTOR) : $(INCORRECT_CARD_RESULT_RADIO_INPUT_SELECTOR);
      if (response.success) {
        createAlert('success', 'Correct!');
      } else {
        createAlert('danger', 'Incorrect!');
      }
      radio_input.prop('checked', true).click();
    },
    error: function(xhr) {
      console.log("ERROR! /cards/guess GET failed");
      console.log(xhr);
    },
    complete: function(xhr, status) {
      // Code to run regardless of success or error
      $(".loading-disable").removeClass('loading-disabled');
    }
  });
});

/**
 * Check if all flashcards have recorded answers.
 * If all flashcards have answers, trigger 'all_card_results_completed' event
 */
window.haveAllCardResultsBeenCompleted = function() {
  const current_slide = $('div.active').index();
  let all_answered = true;
  const l = $( "#card_results_form input[type=checkbox]");
  for (let i = 0; i < l.length; i++) {
    if (i != current_slide){
      const answered = $( "#result_card_results_attributes_" + i + "_correct").data('has-value-been-set');
      if (!answered) {
        all_answered = false;
      }
    }
  }

  if (all_answered) {
    $("body").trigger("all_card_results_completed");
  }
}

/**
 * Triggered when all card results have been completed.
 * Enables the results form submission button
 */
window.allCardResultsCompletedAlert = function() {
  createAlert('success', 'All answers completed, you can now submit your results');
}

window.enableCardResultsSubmit = function() {
  $("#submitResult").prop('disabled', false);
}

$(document).ready(function() {
  setGuessInputPlaceHolder();

  $("body").on('card_result_selected', function () {
    enableNextButton();
    haveAllCardResultsBeenCompleted();
  });

  $("body").on('all_card_results_completed', function () {
    allCardResultsCompletedAlert();
    enableCardResultsSubmit();
  });

  /**
   * Handle slide and slid events of the carousel.
   * When a user navigates to a new card, get the last chosen results of the current card from the form if they exist and update the radio buttons.
   * When the user navigates to another card, store the score values for the last card in a form.
   */
  const myCarousel = document.getElementById('carouselExampleIndicators');

  // slide.bs.carousel occurs BEFORE the slide
  myCarousel.addEventListener('slide.bs.carousel', window.resetGuessForm);
  myCarousel.addEventListener('slide.bs.carousel', window.clearGuessInputPlaceHolder);
  myCarousel.addEventListener('slide.bs.carousel', window.disableNextButton);
  myCarousel.addEventListener('slide.bs.carousel', window.resetCardFlip);
  myCarousel.addEventListener('slide.bs.carousel', window.clearGuessInputPlaceHolder);

  // slid.bs.carousel occurs AFTER the slide
  myCarousel.addEventListener('slid.bs.carousel', window.populateGuessFormWithCardResultForm)
  myCarousel.addEventListener('slid.bs.carousel', window.setGuessInputPlaceHolder)
  myCarousel.addEventListener('slid.bs.carousel', window.resetCardFlip)
  myCarousel.addEventListener('slid.bs.carousel', window.setFocusToGuessInput)

});
