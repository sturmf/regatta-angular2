// Because Angular is using dart:html, we need these tests to run on an actual
// browser. This means that it should be run with `-p dartium` or `-p chrome`.
@TestOn('browser')
import 'dart:async';

// Replaced with code generation.
import 'package:angular2/src/core/reflection/reflection.dart';
import 'package:angular2/src/core/reflection/reflection_capabilities.dart';

// Experimental. Will be published under package:angular2/testing.dart soon.
import 'package:angular2/src/modules/testing/lib/testing.dart';

import 'package:angular2/angular2.dart';
import 'package:test/test.dart';

import 'package:frontend/event_list_component.dart';


@Component(
    selector: 'test-cmp',
    template: '<textarea> \n\n</textarea>')
class TestComponent {}


void main() {
  reflector.reflectionCapabilities = new ReflectionCapabilities();

  test("String.split() splits the string on the delimiter", () {
    final string = "foo,bar,baz";
    expect(string.split(","), equals(["foo", "bar", "baz"]));
  });

/*
  test('New event list component is empty', () async {
    print('test start');
    var testBed = new NgTestBed<TestComponent>();
    var fixture = await testBed.create();


    print(fixture);
    //expect(string.split(","), equals(["foo", "bar", "baz"]));
    //eventListComponent.debugElement.queryAll(());
    //nativeElement.
    //.text, equals('1;2;'));

    // var regattaList = element.all(by.css('.list-group-item'))
  });
  */
}