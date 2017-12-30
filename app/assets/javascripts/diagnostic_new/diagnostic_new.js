$(document).ready(function () {
    $("a.add-next-level").click(function () {
        var indexOfNextInputRow = $("div.input-row").length;
        $("div.input-row-container").append(diagnosticInputRow(indexOfNextInputRow));
        assignScoreCalculationListener(indexOfNextInputRow);
    });

    var startingNumberOfRows = $("div.input-row").length;
    for (var i = 0; i < startingNumberOfRows; i++) {
        assignScoreCalculationListener(i);
    }

});

function diagnosticInputRow(inputRowIndex) {
    return $(
        '<div class="row-container input-row">' +
            diagnosticAttribute('reading_level', inputRowIndex) +
            diagnosticAttribute('number_of_tested_words', inputRowIndex) +
            diagnosticAttribute('phonics_score', inputRowIndex, 'phonics-score') +
            '<div class="diagnostic-form-group">' +
                '<p class="percentage-words-recognised"></p>' +
            '</div>' +
            diagnosticAttribute('fluency_score', inputRowIndex) +
            diagnosticAttribute('comprehension_score', inputRowIndex) +
        '</div>'
    );
}

function diagnosticAttribute(attribute, inputRowIndex, extraClass) {
    var attributeName = diagnosticAttributeName(attribute, inputRowIndex);
    var attributeId = diagnosticAttributeId(attribute, inputRowIndex);

    var firstDiv;
    if (extraClass) {
        firstDiv = '<div class="diagnostic-form-group ' + extraClass + '">'
    } else {
        firstDiv = '<div class="diagnostic-form-group">'
    }

    return firstDiv +
            '<input type="number" class="diagnostic-form-input" name=' + attributeName + 'id=' + attributeId + '>' +
        '</div>';
}

function diagnosticAttributeName(attribute, inputRowIndex) {
    var name = "diagnostic[levels_attributes][" + inputRowIndex + "][" + attribute + "]";
    return '"' + name + '"';
}

function diagnosticAttributeId(attribute, inputRowIndex) {
    var id =  'diagnostic_levels_attributes_' + inputRowIndex + '_' + attribute;
    return '"' + id + '"';
}

function assignScoreCalculationListener(inputRowIndex) {
    var numberOfTestedWordsSelector = "input#diagnostic_levels_attributes_" + inputRowIndex + "_number_of_tested_words";
    var phonicsScoreInput = $("input#diagnostic_levels_attributes_" + inputRowIndex + "_phonics_score");

    phonicsScoreInput.keyup(function () {
        var parentRowContainer = phonicsScoreInput.parent().parent("div.row-container");
        var percentageWordsRecognised = parentRowContainer.find("p.percentage-words-recognised");

        var percentageCorrect = calculatePercentage(phonicsScoreInput.val(), $(numberOfTestedWordsSelector).val());
        percentageWordsRecognised.text(percentageCorrect + "%");
    });
}

function calculatePercentage(numerator, denominator) {
    return Math.round((numerator / denominator) * 100);
}
