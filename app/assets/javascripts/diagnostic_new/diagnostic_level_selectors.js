function levelAttributeInputName(attribute, inputRowIndex) {
    return "diagnostic[levels_attributes][" + inputRowIndex + "][" + attribute + "]";
}

function levelAttributeInputID(attribute, inputRowIndex) {
    return  'diagnostic_levels_attributes_' + inputRowIndex + '_' + attribute;
}

function levelAttributeDisplayID(attribute, inputRowIndex) {
    return levelAttributeInputID(attribute, inputRowIndex) + "_display";
}


function percentageWordsRecognisedID(inputRowIndex) {
    return "diagnostic_levels_" + inputRowIndex + "_percentage_words_recognised"
}


function levelAttributeInput(attribute, inputRowIndex) {
    return $('#' + levelAttributeInputID(attribute, inputRowIndex));
}

function getNumberOfInputRows() {
    return $(".input-row-container > div.input-row").length;
}

function getDiagnosticTemplateLevels(templateNumber) {
    var levelsData = $("#levels_information").data().levelsInformation;
    var templateIndex = templateNumber - 1;

    return levelsData[templateIndex];
}