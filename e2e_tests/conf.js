var SpecReporter = require('/usr/local/lib/node_modules/jasmine-spec-reporter');

exports.config = {
  capabilities: {
    'browserName': 'firefox'
  },
  onPrepare: function() {
     // add jasmine spec reporter
     jasmine.getEnv().addReporter(new SpecReporter({displayStacktrace: 'none'}));
  },
  framework: 'jasmine2',
  seleniumAddress: 'http://localhost:4444/wd/hub',
  specs: ['regatta-spec.js'],
  useAllAngular2AppRoots: true,
};
