// Because Angular is using dart:html, we need these tests to run on an actual
// browser. This means that it should be run with `-p dartium` or `-p chrome`.
@TestOn('browser')
import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:test/test.dart';
import 'package:pageloader/html.dart';
import 'package:pageloader/objects.dart';

@Component(selector: 'test-cmp', template: '<textarea>Hello World!\n</textarea>')
class DummyComponent {}

@EnsureTag('test-cmp')
class TestComponentPO {
  @ByTagName('textarea')
  PageLoaderElement _textArea;

  /// Text
  Future<String> get text => _textArea.visibleText;
}

@AngularEntrypoint()
void main() {
  tearDown(disposeAnyRunningTest);

  test('DummyComponent "Hello World!" test', () async {
    final testBed = new NgTestBed<DummyComponent>();
    final fixture = await testBed.create();

    // Get a handle to the list.
    final pageObject = await fixture.resolvePageObject/*<TestComponentPO>*/(
      TestComponentPO,
    );

    expect(await pageObject.text, equals('Hello World!'));
  });
}
