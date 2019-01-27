// Because Angular is using dart:html, we need these tests to run on an actual
// browser. This means that it should be run with `-p chrome` or `-p firefox`.
@TestOn('browser')

import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:test/test.dart';
import 'package:pageloader/pageloader.dart';
import 'package:pageloader/html.dart';
import 'example_test.template.dart' as ng;

part 'example_test.g.dart';

@Component(selector: 'test-cmp', template: '<textarea>Hello World!\n</textarea>')
class DummyComponent {}

@PageObject()
abstract class TestComponentPO {
  TestComponentPO();
  factory TestComponentPO.create(PageLoaderElement context) = $TestComponentPO.create;

  @ByTagName('textarea')
  PageLoaderElement get _textArea;

  /// Text
  String get text => _textArea.visibleText;
}

void main() {

  final testBed = NgTestBed.forComponent<DummyComponent>(ng.DummyComponentNgFactory);
  NgTestFixture<DummyComponent> fixture;
  TestComponentPO testPO;

  setUp(() async {
    fixture = await testBed.create();
    final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
    testPO = TestComponentPO.create(context);
  });

  tearDown(disposeAnyRunningTest);

  test('DummyComponent "Hello World!" test', () async {
    expect(testPO.text, equals('Hello World!'));
  });
}
