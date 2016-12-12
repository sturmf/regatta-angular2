'use strict';

var EventListPage = function () {
  browser.get('http://localhost:8080/');
};

 EventListPage.prototype = Object.create({}, {
    heading: { get: function () { return element(by.css('h1')).getText(); }},
    newEventForm: { get: function () { return element(by.css('input')); }},
    addButton: { get: function () { return element(by.id('addButton')); }},
    eventList: { get: function () { return element(by.id('eventList')).all(by.css('.event-item')); }},
    eventListLength: { get: function () { return this.eventList.count(); }},

    clickAddButton: { value: function () {
      this.addButton.click();
      // FIXME: why do we need this hack? originally mentioned here: http://stackoverflow.com/questions/21748442/protractor-how-to-wait-for-page-complete-after-click-a-button
      browser.driver.sleep(1);
      browser.waitForAngular();
    }},
    typeIntoNewEventForm: { value: function (input) { this.newEventForm.sendKeys(input); }}
 });

module.exports = EventListPage;
