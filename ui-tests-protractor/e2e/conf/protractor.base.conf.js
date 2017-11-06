// Protractor configuration file, see link for more information
// https://github.com/angular/protractor/blob/master/docs/referenceConf.js

let reporter = require('cucumber-html-reporter');
let fse = require('fs-extra');
let path = require('path');
const os = require('os');
let merge = require('merge');

// define paths for cucumber test framework
let testPath = path.resolve('e2e/');
let reportsPath = path.join(testPath, 'cucumber-reports/');
let cucumberJsonPath = path.join(reportsPath, 'cucumber-report.json');
let cucumberHtmlPath = path.join(reportsPath, 'cucumber-report.html');

let useBrowser = process.env.BROWSER || null;

if (useBrowser === 'firefox') {

  console.log('Using Firefox browser.');
  config = { 
    capabilities: {
      'browserName': 'firefox'
    }
  };
  
} else if (useBrowser === 'all') {
  console.log('Using all possible browsers at the same time.');
  config = {
    multiCapabilities: [{
      'browserName': 'firefox'
    }, {
      'browserName': 'chrome',
      'chromeOptions': {
        'args': ['--no-sandbox']
      }
    }],    
  };
  //or without if so chrome is default
} else if (useBrowser === 'chrome'){  

  console.log('Using Chrome as default browser. Run \`export BROWSER=Firefox\` to use Firefox.');  
  config = { 
    capabilities: {
      'browserName': 'chrome',
      'chromeOptions': {
        'args': ['--no-sandbox']
      }
    },    
  };
}

exports.config = merge(config, {
  allScriptsTimeout: 11000,
  specs: [
    testPath + '/**/*.feature'
  ],
  directConnect: true,
  baseUrl: 'http://localhost:4200/',
  framework: 'custom',
  frameworkPath: require.resolve('protractor-cucumber-framework'),
  cucumberOpts: {
    require: [
      testPath + '/env.ts',
      testPath + '/**/*.steps.ts'
    ],
    format: [
      'pretty',
      'json:' + cucumberJsonPath
    ]
  },
  onPrepare: function () {
    // do stuff like set browser window size...
    // the set window size was moved to env.ts
    // because of browser restart afterFeature
    require('ts-node').register({
      project: 'e2e'
    });
  },
  useAllAngular2AppRoots: true,
  beforeLaunch: function () {
    
    // ensure we have empty directory to store cucumber reports
    fse.emptyDirSync(reportsPath);
  },
  afterLaunch: function () {
    // see docs https://www.npmjs.com/package/cucumber-html-reporter
    let options = {
      theme: 'bootstrap',
      jsonFile: cucumberJsonPath,
      output: cucumberHtmlPath,
      reportSuiteAsScenarios: true,
      storeScreenShots: false,
      launchReport: false,
      metadata: {
        "Browser": "Chrome",
        "Platform": `${os.platform()}  ${os.release()} (${os.arch()})`,
        "Parallel": "no",
      }
    };
    reporter.generate(options);
  }  
});
