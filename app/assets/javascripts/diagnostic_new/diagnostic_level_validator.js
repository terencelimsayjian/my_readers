function performValidations() {
    var numberOfInputRows = getNumberOfInputRows();
    for (var i = 0; i < numberOfInputRows; i++) {
        (function () {
            var phonicsScoreInput = document.getElementById(levelAttributeInputID('phonics_score', i));
            var numberOfTestedWords = levelAttributeInput('number_of_tested_words', i).val();
            var phonicsScore = levelAttributeInput('phonics_score', i).val();

            if (!phonicsScoreLessThanTestedWords(phonicsScore, numberOfTestedWords)) {
                phonicsScoreInput.setCustomValidity("Phonics score must be less than total number of words.");
            }

            var earlierLevelsFailScoreThreshold = !phonicsScorePassesThreshold(phonicsScore, numberOfTestedWords) && (i < numberOfInputRows - 1);

            if (earlierLevelsFailScoreThreshold) {
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
