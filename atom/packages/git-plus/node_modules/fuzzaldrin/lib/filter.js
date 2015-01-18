(function() {
  var scorer;

  scorer = require('./scorer');

  module.exports = function(candidates, query, queryHasSlashes, _arg) {
    var candidate, key, maxResults, score, scoredCandidate, scoredCandidates, string, _i, _len, _ref;
    _ref = _arg != null ? _arg : {}, key = _ref.key, maxResults = _ref.maxResults;
    if (query) {
      scoredCandidates = [];
      for (_i = 0, _len = candidates.length; _i < _len; _i++) {
        candidate = candidates[_i];
        string = key != null ? candidate[key] : candidate;
        if (!string) {
          continue;
        }
        score = scorer.score(string, query, queryHasSlashes);
        if (!queryHasSlashes) {
          score = scorer.basenameScore(string, query, score);
        }
        if (score > 0) {
          scoredCandidates.push({
            candidate: candidate,
            score: score
          });
        }
      }
      scoredCandidates.sort(function(a, b) {
        return b.score - a.score;
      });
      candidates = (function() {
        var _j, _len1, _results;
        _results = [];
        for (_j = 0, _len1 = scoredCandidates.length; _j < _len1; _j++) {
          scoredCandidate = scoredCandidates[_j];
          _results.push(scoredCandidate.candidate);
        }
        return _results;
      })();
    }
    if (maxResults != null) {
      candidates = candidates.slice(0, maxResults);
    }
    return candidates;
  };

}).call(this);
