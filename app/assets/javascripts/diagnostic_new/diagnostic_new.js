$(document).on('turbolinks:load', function () {
    $(".clickable-link-container > a.add-next-level").click(function () {
        var indexOfNextInputRow = $("div.input-row").length;
        $("div.input-row-container").append(diagnosticInputRow(indexOfNextInputRow));
        assignScoreCalculationListener(indexOfNextInputRow);
    });

    $(".clickable-link-container > a.remove-latest-level").click(function () {
        var numberOfInputRows = $("div.input-row").length;

        if (numberOfInputRows > 1) {
            $("div.input-row").last().remove();
        }
    });

    var startingNumberOfRows = $(".diagnostic-form-container > .new_diagnostic > .input-row-container > div.input-row").length;
    for (var i = 0; i < startingNumberOfRows; i++) {
        assignScoreCalculationListener(i);
    }

    $(".submit-new-diagnostic").click(function () {
        var numberOfInputRows = $("div.input-row").length;

        for (var i = 0; i < numberOfInputRows; i++) {
            if (!phonicsScoreValidator(i)) {
                var phonicsScoreInput = document.getElementById('diagnostic_levels_attributes_' + i + '_phonics_score');
                phonicsScoreInput.setCustomValidity("Phonics score must be less than total number of words.");
            }
        }
    })

});

function diagnosticInputRow(inputRowIndex) {
    return $(
        '<div class="row-container input-row">' +
            '<div class="diagnostic-form-group">' +
                '<input type="hidden" value=' + (inputRowIndex + 1) + ' class="diagnostic-form-input" name=' + diagnosticAttributeName('reading_level', inputRowIndex) + 'id=' + diagnosticAttributeId('reading_level', inputRowIndex) + '>' +
                '<p>' + (inputRowIndex + 1) + '</p>' +
            '</div>' +
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
            '<input type="number" class="diagnostic-form-input" name=' + attributeName + 'id=' + attributeId + ' required>' +
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
    var phonicsScoreJqueryInput = $("input#diagnostic_levels_attributes_" + inputRowIndex + "_phonics_score");
    var phonicsScoreHtmlInput = document.getElementById('diagnostic_levels_attributes_' + inputRowIndex + '_phonics_score');

    phonicsScoreJqueryInput.keyup(function () {
        phonicsScoreHtmlInput.setCustomValidity("");
        var parentRowContainer = phonicsScoreJqueryInput.parent().parent("div.row-container");
        var percentageWordsRecognised = parentRowContainer.find("p.percentage-words-recognised");

        var percentageCorrect = calculatePercentage(phonicsScoreJqueryInput.val(), $(numberOfTestedWordsSelector).val());
        percentageWordsRecognised.text(percentageCorrect + "%");
    });
}

function phonicsScoreValidator(inputRowIndex) {
    var numberOfTestedWordsSelector = "input#diagnostic_levels_attributes_" + inputRowIndex + "_number_of_tested_words";
    var phonicsScoreInput = $("input#diagnostic_levels_attributes_" + inputRowIndex + "_phonics_score");

    return $(numberOfTestedWordsSelector).val() >= phonicsScoreInput.val();
}

function calculatePercentage(numerator, denominator) {
    return Math.round((numerator / denominator) * 100);
}
