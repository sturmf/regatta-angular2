describe('Regatta welcome page', function() {
  it('Should tell the user its name.', function() {
    browser.get('http://localhost:8080/');
    var heading = element(by.css('h1'));
    expect(heading.getText()).toEqual('Regatta');
  });
});
