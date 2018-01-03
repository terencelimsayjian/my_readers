$(document).on('turbolinks:load', function () {
    var startingNumberOfRows = $(".diagnostic-form-container > .new_diagnostic > .input-row-container > div.input-row").length;
    for (var i = 0; i < startingNumberOfRows; i++) {
        assignScoreCalculationListener(i);
    }

    $(".clickable-link-container > a.add-next-level").click(function () {
        var levelsData = $("#levels_information").data().levelsInformation;
        var inputRowIndex = $("div.input-row").length;

        var numberOfWords = levelsData[inputRowIndex]
        $("div.input-row-container").append(diagnosticInputRow(inputRowIndex, numberOfWords));

        assignScoreCalculationListener(inputRowIndex);
    });

    $(".clickable-link-container > a.remove-latest-level").click(function () {
        var numberOfInputRows = $("div.input-row").length;
        if (numberOfInputRows > 1) {
            $("div.input-row").last().remove();
        }
    });

    $(".submit-new-diagnostic").click(performValidations);
});

function performValidations() {
    var numberOfInputRows = $("div.input-row").length;
    for (var i = 0; i < numberOfInputRows; i++) {
        (function () {
            var phonicsScoreInput = document.getElementById('diagnostic_levels_attributes_' + i + '_phonics_score');
            var numberOfTestedWords = diagnosticsLevelJqueryElement('number_of_tested_words', i).val();
            var phonicsScore = diagnosticsLevelJqueryElement('phonics_score', i).val();

            if (!phonicsScoreLessThanTestedWords(phonicsScore, numberOfTestedWords)) {
                phonicsScoreInput.setCustomValidity("Phonics score must be less than total number of words.");
            }

            if (!phonicsScorePassesThreshold(phonicsScore, numberOfTestedWords) && (i < numberOfInputRows - 1)) {
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

function diagnosticInputRow(inputRowIndex, numberOfTestedWords) {
    return $(
        '<div class="row-container input-row">' +
            hiddenDiagnosticAttribute('reading_level', inputRowIndex) +
            '<div class="diagnostic-form-group">' +
                '<input type="hidden" value=' + numberOfTestedWords + ' class="diagnostic-form-input" name=' + diagnosticAttributeName('number_of_tested_words', inputRowIndex) + 'id=' + diagnosticAttributeId('number_of_tested_words', inputRowIndex) + '>' +
                '<p>' + numberOfTestedWords + '</p>' +
            '</div>' +
            diagnosticAttribute('phonics_score', inputRowIndex, 'phonics-score') +
            '<div class="diagnostic-form-group">' +
                '<p class="percentage-words-recognised"></p>' +
            '</div>' +
            diagnosticAttribute('fluency_score', inputRowIndex) +
            diagnosticAttribute('comprehension_score', inputRowIndex) +
        '</div>'
    );
}

function hiddenDiagnosticAttribute(attribute, inputRowIndex) {
    var attributeName = diagnosticAttributeName(attribute, inputRowIndex);
    var attributeId = diagnosticAttributeId(attribute, inputRowIndex);

    return '<div class="diagnostic-form-group">' +
                '<input type="hidden" value=' + (inputRowIndex + 1) + ' class="diagnostic-form-input" name=' + attributeName + 'id=' + attributeId + '>' +
                '<p>' + (inputRowIndex + 1) + '</p>' +
            '</div>';
}

function diagnosticAttribute(attribute, inputRowIndex, extraClass) {
    var attributeName = diagnosticAttributeName(attribute, inputRowIndex);
    var attributeId = diagnosticAttributeId(attribute, inputRowIndex);
    var classes = extraClass ? ['diagnostic-form-group', extraClass] : ['diagnostic-form-group'];

    return divWithClasses(classes) +
            '<input type="number" class="diagnostic-form-input" name=' + attributeName + 'id=' + attributeId + ' required>' +
        '</div>';
}

function divWithClasses(classes) {
    return '<div class="' + classes.join(' ') + '">';
}

function diagnosticAttributeName(attribute, inputRowIndex) {
    var name = "diagnostic[levels_attributes][" + inputRowIndex + "][" + attribute + "]";
    return '"' + name + '"';
}

function diagnosticAttributeId(attribute, inputRowIndex) {
    var id =  'diagnostic_levels_attributes_' + inputRowIndex + '_' + attribute;
    return '"' + id + '"';
}

function diagnosticsLevelJqueryElement(attribute, inputRowIndex) {
    return $('#diagnostic_levels_attributes_' + inputRowIndex + '_' + attribute);
}

function assignScoreCalculationListener(inputRowIndex) {
    var numberOfTestedWords = diagnosticsLevelJqueryElement('number_of_tested_words', inputRowIndex).val();
    var phonicsScoreJqueryInput = diagnosticsLevelJqueryElement('phonics_score', inputRowIndex);
    var phonicsScoreHtmlInput = document.getElementById('diagnostic_levels_attributes_' + inputRowIndex + '_phonics_score');

    phonicsScoreJqueryInput.keyup(function () {
        phonicsScoreHtmlInput.setCustomValidity("");
        var parentRowContainer = phonicsScoreJqueryInput.parent().parent("div.row-container");
        var percentageWordsRecognised = parentRowContainer.find("p.percentage-words-recognised");

        var percentageCorrect = calculatePercentage(phonicsScoreJqueryInput.val(), numberOfTestedWords);
        percentageWordsRecognised.text(percentageCorrect + "%");
    });
}

function calculatePercentage(numerator, denominator) {
    return Math.round((numerator / denominator) * 100);
}
