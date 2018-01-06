"use strict";

$(document).on('turbolinks:load', function () {
    var startingNumberOfRows = $(".diagnostic-form-container > .new_diagnostic > .input-row-container > div.input-row").length;
    for (var i = 0; i < startingNumberOfRows; i++) {
        assignScoreCalculationListener(i);
    }

    $("a.add-next-level").click(addNextInputRow);

    $("a.remove-latest-level").click(removeLastInputRow);

    $(".submit-new-diagnostic").click(performValidations);
});

function addNextInputRow() {
    var levelsData = $("#levels_information").data().levelsInformation;
    var inputRowIndex = $("div.input-row").length;
    var numberOfWords = levelsData[inputRowIndex];

    if (inputRowIndex < 11) {
        $("div.input-row-container").append(diagnosticInputRow(inputRowIndex, numberOfWords));
        assignScoreCalculationListener(inputRowIndex);
    }
}

function removeLastInputRow() {
    var numberOfInputRows = $("div.input-row").length;
    if (numberOfInputRows > 1) {
        $("div.input-row").last().remove();
    }
}

function performValidations() {
    var numberOfInputRows = $("div.input-row").length;
    for (var i = 0; i < numberOfInputRows; i++) {
        (function () {
            var phonicsScoreInput = document.getElementById(levelAttributeInputID('phonics_score', i));
            var numberOfTestedWords = levelAttributeInput('number_of_tested_words', i).val();
            var phonicsScore = levelAttributeInput('phonics_score', i).val();

            if (!phonicsScoreLessThanTestedWords(phonicsScore, numberOfTestedWords)) {
                phonicsScoreInput.setCustomValidity("Phonics score must be less than total number of words.");
            }

            var earlierLevelsPassScoreThreshold = !phonicsScorePassesThreshold(phonicsScore, numberOfTestedWords) && (i < numberOfInputRows - 1);
            if (earlierLevelsPassScoreThreshold) {
                phonicsScoreInput.setCustomValidity("Phonics score must be 99% or higher before proceeding to next level.");
            }
        })();
    }
}

function phonicsScoreLessThanTestedWords(phonicsScore, numberOfTestedWords) {
    return parseInt(numberOfTestedWords) >= parseInt(phonicsScore);
}

function phonicsScorePassesThreshold(phonicsScore, numberOfTestedWords) {
    var roundedPercentageScore = parseFloat((parseFloat(phonicsScore)/numberOfTestedWords).toFixed(2));
    return roundedPercentageScore >= 0.99;
}

function assignScoreCalculationListener(inputRowIndex) {
    var numberOfTestedWords = levelAttributeInput('number_of_tested_words', inputRowIndex).val();
    var phonicsScoreJqueryInput = levelAttributeInput('phonics_score', inputRowIndex);
    var phonicsScoreHtmlInput = document.getElementById(levelAttributeInputID('phonics_score', inputRowIndex));

    phonicsScoreJqueryInput.keyup(function () {
        phonicsScoreHtmlInput.setCustomValidity("");
        var parentRowContainer = phonicsScoreJqueryInput.parent().parent("div.row-container");
        var percentageWordsRecognised = parentRowContainer.find("p.percentage-words-recognised");

        var percentageCorrect = calculatePercentage(phonicsScoreJqueryInput.val(), numberOfTestedWords);
        percentageWordsRecognised.text(percentageCorrect + "%");
    });
}

function diagnosticInputRow(inputRowIndex, numberOfTestedWords) {
    return $(
        '<div class="row-container input-row">' +
            hiddenDiagnosticAttribute('reading_level', inputRowIndex, inputRowIndex + 1) +
            hiddenDiagnosticAttribute('number_of_tested_words', inputRowIndex, numberOfTestedWords) +
            diagnosticAttribute('phonics_score', inputRowIndex, 'phonics-score') +
            '<div class="diagnostic-form-group">' +
                '<p class="percentage-words-recognised"></p>' +
            '</div>' +
            diagnosticAttribute('fluency_score', inputRowIndex) +
            diagnosticAttribute('comprehension_score', inputRowIndex) +
        '</div>'
    );
}

function hiddenDiagnosticAttribute(attribute, inputRowIndex, inputValue) {
    var attributeName = levelAttributeInputName(attribute, inputRowIndex);
    var attributeId = levelAttributeInputID(attribute, inputRowIndex);

    return '<div class="diagnostic-form-group">' +
                '<input type="hidden" value=' + inputValue + ' class="diagnostic-form-input" name="' + attributeName + '" id="' + attributeId + '">' +
                '<p>' + inputValue + '</p>' +
            '</div>';
}

function diagnosticAttribute(attribute, inputRowIndex, extraClass) {
    var attributeName = levelAttributeInputName(attribute, inputRowIndex);
    var attributeId = levelAttributeInputID(attribute, inputRowIndex);
    var classes = extraClass ? ['diagnostic-form-group', extraClass] : ['diagnostic-form-group'];

    return '<div class="' + classes.join(' ') + '">' +
                '<input type="number" class="diagnostic-form-input" name="' + attributeName + '" id="' + attributeId + '" required>' +
            '</div>';
}

function calculatePercentage(numerator, denominator) {
    return Math.round((numerator / denominator) * 100);
}

function levelAttributeInputName(attribute, inputRowIndex) {
    return "diagnostic[levels_attributes][" + inputRowIndex + "][" + attribute + "]";
}

function levelAttributeInputID(attribute, inputRowIndex) {
    return  'diagnostic_levels_attributes_' + inputRowIndex + '_' + attribute;
}

function levelAttributeInput(attribute, inputRowIndex) {
    return $('#' + levelAttributeInputID(attribute, inputRowIndex));
}
