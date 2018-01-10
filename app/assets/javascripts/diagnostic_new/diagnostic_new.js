$(document).on('turbolinks:load', function () {
    $("#diagnostic_index_1").click(changeDiagnosticTemplate.bind(this, 1));
    $("#diagnostic_index_2").click(changeDiagnosticTemplate.bind(this, 2));
    $("#diagnostic_index_3").click(changeDiagnosticTemplate.bind(this, 3));
    $("#diagnostic_index_4").click(changeDiagnosticTemplate.bind(this, 4));

    for (var i = 0; i < getNumberOfInputRows(); i++) {
        assignScoreCalculationListener(i);
    }

    $("a.add-next-level").click(addNextInputRow.bind(this, 0));

    $("a.remove-latest-level").click(removeLastInputRow);

    $(".submit-new-diagnostic").click(performValidations);
});

function changeDiagnosticTemplate(templateNumber) {
    var existingNumberOfInputRows = getNumberOfInputRows();
    var diagnosticTemplateData = getDiagnosticTemplateLevels(templateNumber);

    for (var i = 0; i < existingNumberOfInputRows; i++) {
        replaceNumberOfWordsForLevel(i, diagnosticTemplateData[i]);
        var phonicsScoreInput = levelAttributeInput('phonics_score', i);

        assignScoreCalculationListener(i);
        if (phonicsScoreInput.val() !== "") {
            phonicsScoreInput.keyup(); // to refresh scores
        }

        $("a.add-next-level").off("click");
        $("a.add-next-level").click(addNextInputRow.bind(this, templateNumber - 1));
    }
}

function replaceNumberOfWordsForLevel(index, newValue) {
    var numberOfWordsInput = $("#" + levelAttributeInputID('number_of_tested_words', index));
    var numberOfWordsDisplay = $("#" + levelAttributeDisplayID('number_of_tested_words', index));

    numberOfWordsInput.val(newValue);
    numberOfWordsDisplay.text(newValue);
}

function assignScoreCalculationListener(inputRowIndex) {
    var phonicsScoreJqueryInput = levelAttributeInput('phonics_score', inputRowIndex);
    var phonicsScoreHtmlInput = document.getElementById(levelAttributeInputID('phonics_score', inputRowIndex));
    var percentageWordsRecognisedTag = $("#" + percentageWordsRecognisedID(inputRowIndex));
    var numberOfTestedWords = levelAttributeInput('number_of_tested_words', inputRowIndex).val();

    phonicsScoreJqueryInput.keyup(function () {
        phonicsScoreHtmlInput.setCustomValidity("");

        var percentageCorrect = calculatePercentage(phonicsScoreJqueryInput.val(), numberOfTestedWords);
        percentageWordsRecognisedTag.text(percentageCorrect + "%");
    });
}

function addNextInputRow(diagnosticTemplateIndex) {
    var inputRowIndex = getNumberOfInputRows();
    var diagnosticTemplateNumber = diagnosticTemplateIndex + 1;
    var numberOfWords = getDiagnosticTemplateLevels(diagnosticTemplateNumber)[inputRowIndex];

    if (inputRowIndex < 11) {
        $("div.input-row-container").append(diagnosticInputRow(inputRowIndex, numberOfWords));
        assignScoreCalculationListener(inputRowIndex);
    }
}

function removeLastInputRow() {
    if (getNumberOfInputRows() > 1) {
        $("div.input-row").last().remove();
    }
}

function calculatePercentage(numerator, denominator) {
    return Math.round((numerator / denominator) * 100);
}
