(function() {
  var runas, searchCommand;

  runas = require('../build/Release/runas.node');

  searchCommand = function(command) {
    var e, filename, fs, p, path, paths, _i, _len;
    if (command[0] === '/') {
      return command;
    }
    fs = require('fs');
    path = require('path');
    paths = process.env.PATH.split(path.delimiter);
    for (_i = 0, _len = paths.length; _i < _len; _i++) {
      p = paths[_i];
      try {
        filename = path.join(p, command);
        if (fs.statSync(filename).isFile()) {
          return filename;
        }
      } catch (_error) {
        e = _error;
      }
    }
    return '';
  };

  module.exports = function(command, args, options) {
    if (args == null) {
      args = [];
    }
    if (options == null) {
      options = {};
    }
    if (options.hide == null) {
      options.hide = true;
    }
    if (options.admin == null) {
      options.admin = false;
    }
    if (process.platform === 'darwin' && options.admin === true) {
      command = searchCommand(command);
    }
    return runas.runas(command, args, options);
  };

}).call(this);
