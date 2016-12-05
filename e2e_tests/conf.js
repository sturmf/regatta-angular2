var SpecReporter = require('jasmine-spec-reporter');

exports.config = {
  capabilities: {
    'browserName': 'firefox'
  },
  onPrepare: function() {
     jasmine.getEnv().addReporter(new SpecReporter({displayStacktrace: 'none'}));
  },
  framework: 'jasmine2',
  jasmineNodeOpts: {
    showColors: true,
    defaultTimeoutInterval: 30000,
    print: function() {}
  },
  seleniumAddress: 'http://localhost:4444/wd/hub',
  specs: ['regatta-spec.js'],
  useAllAngular2AppRoots: true,
};
