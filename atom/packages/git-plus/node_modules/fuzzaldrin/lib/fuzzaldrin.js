(function() {
  var SpaceRegex, filter, matcher, scorer;

  scorer = require('./scorer');

  filter = require('./filter');

  matcher = require('./matcher');

  SpaceRegex = /\ /g;

  module.exports = {
    filter: function(candidates, query, options) {
      var queryHasSlashes;
      if (query) {
        queryHasSlashes = query.indexOf('/') !== -1;
        query = query.replace(SpaceRegex, '');
      }
      return filter(candidates, query, queryHasSlashes, options);
    },
    score: function(string, query) {
      var queryHasSlashes, score;
      if (!string) {
        return 0;
      }
      if (!query) {
        return 0;
      }
      if (string === query) {
        return 2;
      }
      queryHasSlashes = query.indexOf('/') !== -1;
      query = query.replace(SpaceRegex, '');
      score = scorer.score(string, query);
      if (!queryHasSlashes) {
        score = scorer.basenameScore(string, query, score);
      }
      return score;
    },
    match: function(string, query) {
      if (!string) {
        return [''];
      }
      if (!query) {
        return [string];
      }
      if (string === query) {
        return ['', string];
      }
      query = query.replace(SpaceRegex, '');
      return matcher.match(string, query);
    }
  };

}).call(this);
