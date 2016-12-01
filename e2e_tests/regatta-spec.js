jasmine.DEFAULT_TIMEOUT_INTERVAL = 120000;


describe('The Regatta welcome view', function() {
  browser.get('http://localhost:8080/');
  var heading = element(by.css('h1'));
  var newRegattaForm = element(by.css('input'));
  var addButton = element(by.id('addButton'));
  var regattaList = element(by.id('eventList')).all(by.css('material-button')); // FIXME: not yet supported, element.all(by.repeater('let event of events'));
  var initialRegattaListLength;

  beforeAll(function(done) {
    element(by.id('eventList')).all(by.css('material-button')).count().then((n) => {
      initialRegattaListLength = n;
      console.log("initialRegattaListLength:", initialRegattaListLength);
      done()
    })
  });

  beforeEach(function() {
  });

  afterEach(function() {
  });

  it('should display the application\'s name.', function() {
    expect(heading.getText()).toEqual('Regatta');
  });

  it('should display initial regatta items.', function() {
    expect(regattaList.count()).toEqual(initialRegattaListLength);
  });

  it('should add a new regatta item.', function() {
    newRegattaForm.sendKeys('Christmas Race');
    addButton.click();

    // FIXME: why do we need this hack? originally mentioned here: http://stackoverflow.com/questions/21748442/protractor-how-to-wait-for-page-complete-after-click-a-button
    browser.driver.sleep(1);
    browser.waitForAngular();

    regattaList = element(by.id('eventList')).all(by.css('material-button')); // FIXME: not yet supported, element.all(by.repeater('let event of events'));
    expect(regattaList.count()).toEqual(initialRegattaListLength + 1);
  });

/*
  xit('should show a list of all regattas.', function() {
    expect('apples').toEqual('oranges');
  });

  xit('should route to a regatta\'s details view.', function() {
    expect('apples').toEqual('oranges');
  });
*/
});
