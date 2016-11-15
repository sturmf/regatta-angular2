// Because Angular is using dart:html, we need these tests to run on an actual
// browser. This means that it should be run with `-p dartium` or `-p chrome`.
@TestOn('browser')
//import 'package:angular2/angular2.dart';
import 'package:angular2/src/testing/angular2_testing.dart';
import 'package:angular2/testing.dart';
import 'package:test/test.dart';

import 'package:frontend/event_list_component.dart';

void main() {
  initAngularTests();

  test("String.split() splits the string on the delimiter", () {
    final string = "foo,bar,baz";
    expect(string.split(","), equals(["foo", "bar", "baz"]));
  });

  
  ngTest('New event list component is empty', (TestComponentBuilder testComponentBuilder) async {
    final eventListComponent = await testComponentBuilder.createAsync(EventListComponent);
    eventListComponent.detectChanges();

    print(eventListComponent);
    
    //eventListComponent.debugElement.queryAll(());
    //nativeElement.
    //.text, equals('1;2;'));

    // var regattaList = element.all(by.css('.list-group-item'))
  });
}
