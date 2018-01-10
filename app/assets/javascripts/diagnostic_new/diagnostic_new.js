"use strict";

$(document).on('turbolinks:load', function () {
    $("#diagnostic_index_1").click(changeDiagnosticTemplate.bind(this, 1));
    $("#diagnostic_index_2").click(changeDiagnosticTemplate.bind(this, 2));
    $("#diagnostic_index_3").click(changeDiagnosticTemplate.bind(this, 3));
    $("#diagnostic_index_4").click(changeDiagnosticTemplate.bind(this, 4));

    function changeDiagnosticTemplate(templateId) {
        var existingNumberOfInputRows = $(".input-row-container > div.input-row").length;
        var levelsData = $("#levels_information").data().levelsInformation;
        var diagnosticTemplateData = levelsData[templateId - 1];
        for (var i = 0; i < existingNumberOfInputRows; i++) {

            replaceNumberOfWordsForLevel(i, diagnosticTemplateData[i]);
            var phonicsScoreInput = levelAttributeInput('phonics_score', i);

            if (phonicsScoreInput.val() !== "") {
                phonicsScoreInput.keyup();
            }

            $("a.add-next-level").off("click");
            $("a.add-next-level").click(addNextInputRow.bind(this, templateId - 1));
        }
    }

    function replaceNumberOfWordsForLevel(index, newValue) {
        var numberOfWordsInput = $("#" + levelAttributeInputID('number_of_tested_words', index));
        var numberOfWordsDisplay = $("#" + levelAttributeDisplayId('number_of_tested_words', index));

        numberOfWordsInput.val(newValue);
        numberOfWordsDisplay.text(newValue);
    }

    var startingNumberOfRows = $(".input-row-container > div.input-row").length;
    for (var i = 0; i < startingNumberOfRows; i++) {
        assignScoreCalculationListener(i);
    }

    $("a.add-next-level").click(addNextInputRow.bind(this, 0));

    $("a.remove-latest-level").click(removeLastInputRow);

    $(".submit-new-diagnostic").click(performValidations);
});

function addNextInputRow(diagnosticTemplateIndex) {
    var levelsData = $("#levels_information").data().levelsInformation;
    var inputRowIndex = $("div.input-row").length;
    var numberOfWords = levelsData[diagnosticTemplateIndex][inputRowIndex]; // can check which radio button is pressed

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
    var phonicsScoreJqueryInput = levelAttributeInput('phonics_score', inputRowIndex);

    phonicsScoreJqueryInput.keyup(function () {
        var numberOfTestedWords = levelAttributeInput('number_of_tested_words', inputRowIndex).val();
        var phonicsScoreHtmlInput = document.getElementById(levelAttributeInputID('phonics_score', inputRowIndex));

        phonicsScoreHtmlInput.setCustomValidity("");
        var percentageWordsRecognisedTag = $("#diagnostic_levels_" + inputRowIndex + "_percentage_words_recognised");

        var percentageCorrect = calculatePercentage(phonicsScoreJqueryInput.val(), numberOfTestedWords);
        percentageWordsRecognisedTag.text(percentageCorrect + "%");
    });
}

function diagnosticInputRow(inputRowIndex, numberOfTestedWords) {
    return $(
        '<div class="row-container input-row">' +
            hiddenDiagnosticAttribute('reading_level', inputRowIndex, inputRowIndex + 1) +
            hiddenDiagnosticAttribute('number_of_tested_words', inputRowIndex, numberOfTestedWords) +
            diagnosticAttribute('phonics_score', inputRowIndex, 'phonics-score') +
            '<div class="diagnostic-form-group">' +
                '<p id="diagnostic_levels_' + inputRowIndex + '_percentage_words_recognised"></p>' +
            '</div>' +
            diagnosticAttribute('fluency_score', inputRowIndex) +
            diagnosticAttribute('comprehension_score', inputRowIndex) +
        '</div>'
    );
}

function hiddenDiagnosticAttribute(attribute, inputRowIndex, inputValue) {
    var attributeName = levelAttributeInputName(attribute, inputRowIndex);
    var attributeId = levelAttributeInputID(attribute, inputRowIndex);
    var attributeDisplayId = levelAttributeDisplayId(attribute, inputRowIndex);

    return '<div class="diagnostic-form-group">' +
                '<input type="hidden" value=' + inputValue + ' class="diagnostic-form-input" name="' + attributeName + '" id="' + attributeId + '">' +
                '<p id="' + attributeDisplayId + '">' + inputValue + '</p>' +
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

function levelAttributeDisplayId(attribute, inputRowIndex) {
    return levelAttributeInputID(attribute, inputRowIndex) + "_display";
}

function levelAttributeInput(attribute, inputRowIndex) {
    return $('#' + levelAttributeInputID(attribute, inputRowIndex));
}
