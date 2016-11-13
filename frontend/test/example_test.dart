// Because Angular is using dart:html, we need these tests to run on an actual
// browser. This means that it should be run with `-p dartium` or `-p chrome`.
@TestOn('browser')
import 'package:angular2/angular2.dart';
import 'package:angular2/src/testing/angular2_testing.dart';
import 'package:angular2/testing.dart';
import "package:test/test.dart";

void main() {
  initAngularTests();

  test("String.split() splits the string on the delimiter", () {
    var string = "foo,bar,baz";
    expect(string.split(","), equals(["foo", "bar", "baz"]));
  });

  /*
  ngTest('create a component using the TestComponentBuilder',
      (TestComponentBuilder tcb) async {
  var rootTC = await tcb
      .overrideTemplate(TestComponent, TEMPLATE)
      .createAsync(TestComponent);

    rootTC.detectChanges();
    expect(rootTC.debugElement.nativeElement.text, equals('1;2;'));
  });
  */
}
