describe('The Regatta welcome view', function() {

  it('should display the application\'s name.', function() {
    browser.get('http://localhost:8080/');
    var heading = element(by.css('h1'));
    expect(heading.getText()).toEqual('Regatta');
  });

  xit('should show a list of all regattas.', function() {
    expect('apple').toEqual('orange');
  });

  xit('should route to a regatta\'s details view.', function() {
    expect('apple').toEqual('orange');
  });

});
