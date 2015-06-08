var curry  = require('light-curry'),
    delvec = require('delvec');

var Objector = function(object) {
  this.object = object;
};

Objector.prototype = {

  get: curry(function(key) {
    return delvec(this.object, key);
  }),

  getOr: curry(function(alternate, key) {
    return delvec.or(this.object, key, alternate);
  }),

  set: curry(function(object, key, value) {
    var steps, key, keys;

    if (arguments.length === 2) {
      value  = key;
      key    = object;
      object = this.object;
    }

    steps = key.split('.');
    key   = steps[0];
    keys  = steps.slice(1);

    if (steps.length === 1) {
      object[key] = value;
      return object;
    } else {
      if (typeof delvec(object, key) !== 'object') {
        object[key] = {};
      }
      return this.set(keys.join('.'), object[key], value);
    }
  })
};

module.exports = Objector;
