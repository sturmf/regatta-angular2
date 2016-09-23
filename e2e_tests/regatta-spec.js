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


  // - The Regatta welcome view should display the application\'s name.
  //
  // - Given the user is at the Regatta welcome view,
  //   and the list of regatta items is not empty,
  //   when he clicks a regatta item,
  //   then the details view of the clicked regatta item is opened.



});
