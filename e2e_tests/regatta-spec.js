describe('The Regatta welcome view', function() {
  var heading = element(by.css('h1'));
  var newRegattaForm = element(by.css('input'));
  var addButton = element(by.buttonText('Add'));
  var regattaList = element.all(by.repeater('let event of events'));

  beforeEach(function() {
    browser.get('http://localhost:8080/');
  });

  it('should display the application\'s name.', function() {
    expect(heading.getText()).toEqual('Regatta');
  });

  it('should start with an empty list.', function() {
    expect(regattaList.count()).toEqual(0);
  });

  it('should add a new regatta item.', function() {
    newRegattaForm.sendKeys('Christmas Race');
    addButton.click();
    expect(regattaList.count()).toEqual(1);
    expect(regattaList).;
  });

  xit('should show a list of all regattas.', function() {
    expect('apples').toEqual('oranges');
  });

  xit('should route to a regatta\'s details view.', function() {
    expect('apples').toEqual('oranges');
  });

});
