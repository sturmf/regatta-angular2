var AngularPage = require('./page_objects/event_list.page.js');

describe('The Regatta event list view', function() {

  var page;
  var initialEventListLength;

  beforeAll(function(done) {
    page = new AngularPage();
    page.eventListLength.then((n) => {
      initialEventListLength = n;
      console.log("initialEventListLength:", initialEventListLength);
      done()
    })
  });

  beforeEach(function() {
    page = new AngularPage();
  });

  afterEach(function() {
  });

  it('should display the application\'s name.', function() {
    expect(page.heading).toEqual('Regatta');
  });

  it('should display initial regatta items.', function() {
    expect(page.eventListLength).toEqual(initialEventListLength);
  });

  it('should add a new regatta item.', function() {
    page.typeIntoNewEventForm('Christmas Race');
    page.clickAddButton();
    expect(page.eventListLength).toEqual(initialEventListLength + 1);
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
