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
import 'package:pageloader/html.dart';
import 'package:pageloader/objects.dart';
import 'package:test/test.dart';


@Component(selector: 'test-cmp', template: '<textarea>Hello World!\n</textarea>')
class DummyComponent {}

@EnsureTag('ng-test-bed')
class TestComponentPO {
  @ByTagName('textarea')
  PageLoaderElement _textArea;

  /// Text
  Future<String> get text => _textArea.visibleText;
}

void main() {
  reflector.reflectionCapabilities = new ReflectionCapabilities();

  test('DummyComponent "Hello World!" test', () async {
    var testBed = new NgTestBed<DummyComponent>();
    var fixture = await testBed.create();
    // Create an instance of the in-browser page loader that uses our fixture.
    var loader = new HtmlPageLoader(
        fixture.element.parent,
        executeSyncedFn: (c) async {
          await c();
          return fixture.update;
        },
        useShadowDom: false
    );

    // Get a handle to the list.
    TestComponentPO po = await loader.getInstance(TestComponentPO);
    expect(await po.text, equals('Hello World!'));
  });
}
