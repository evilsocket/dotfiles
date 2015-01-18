(function() {
  exports.match = function(string, query) {
    var before, character, indexInQuery, indexInString, lowerCaseIndex, matchedChars, matches, minIndex, queryLength, stringLength, upperCaseIndex;
    if (string === query) {
      return 1;
    }
    queryLength = query.length;
    stringLength = string.length;
    indexInQuery = 0;
    indexInString = 0;
    matches = [];
    matchedChars = [];
    while (indexInQuery < queryLength) {
      character = query[indexInQuery++];
      lowerCaseIndex = string.indexOf(character.toLowerCase());
      upperCaseIndex = string.indexOf(character.toUpperCase());
      minIndex = Math.min(lowerCaseIndex, upperCaseIndex);
      if (minIndex === -1) {
        minIndex = Math.max(lowerCaseIndex, upperCaseIndex);
      }
      indexInString = minIndex;
      if (indexInString === -1) {
        return [string];
      }
      before = string.substring(0, indexInString);
      if (matchedChars.length === 0) {
        matches.push(before);
      }
      if (indexInString !== 0 && matchedChars.length > 1) {
        matches.push(matchedChars.join(''));
        matches.push(before);
        matchedChars = [];
      }
      matchedChars.push(string[indexInString]);
      if (indexInQuery === queryLength) {
        matches.push(matchedChars.join(''));
        matches.push(string.substring(indexInString + 1, stringLength));
      }
      string = string.substring(indexInString + 1, stringLength);
    }
    return matches;
  };

}).call(this);
