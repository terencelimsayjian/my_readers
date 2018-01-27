function diagnosticInputRow(inputRowIndex, numberOfTestedWords) {
    return $(
        '<div class="row-container input-row">' +
            hiddenDiagnosticAttribute('reading_level', inputRowIndex, inputRowIndex + 1) +
            hiddenDiagnosticAttribute('number_of_tested_words', inputRowIndex, numberOfTestedWords) +
            diagnosticAttribute('phonics_score', inputRowIndex, 'phonics-score') +
            '<div class="diagnostic-form-group">' +
                '<p id="' + percentageWordsRecognisedID(inputRowIndex) + '"></p>' +
            '</div>' +
            diagnosticAttribute('fluency_score', inputRowIndex) +
            diagnosticAttribute('comprehension_score', inputRowIndex) +
        '</div>'
    );
}

function hiddenDiagnosticAttribute(attribute, inputRowIndex, inputValue) {
    var attributeName = levelAttributeInputName(attribute, inputRowIndex);
    var attributeId = levelAttributeInputID(attribute, inputRowIndex);
    var attributeDisplayId = levelAttributeDisplayID(attribute, inputRowIndex);

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