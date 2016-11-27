// Because Angular is using dart:html, we need these tests to run on an actual
// browser. This means that it should be run with `-p dartium` or `-p chrome`.
@TestOn('browser')

// Replaced with code generation.
import 'package:angular2/src/core/reflection/reflection.dart';
import 'package:angular2/src/core/reflection/reflection_capabilities.dart';

// Experimental. Will be published under package:angular2/testing.dart soon.
import 'package:angular2/src/modules/testing/lib/testing.dart';

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:mockito/mockito_no_mirrors.dart';
import 'package:pageloader/html.dart';
import 'package:test/test.dart';

import 'package:frontend/services/event_service.dart';
import 'package:frontend/event_list_component.dart';
import 'package:frontend/event_list_component_po.dart';
import 'package:frontend/models/event.dart';

// We have to wrap our component in a slim wrapper to resolve it with getInstance later
@Component(selector: 'test', directives: const [EventListComponent], template: '<my-event-list></my-event-list>')
class EventListTestComponent {}

void main() {
  reflector.reflectionCapabilities = new ReflectionCapabilities();

  test('EventListComponent list contains dummy event', () async {
    final router = new MockRouter();
    final service = new MockEventService();
    when(service.getEvents()).thenReturn([new Event(1, 'dummy url')..name = 'Dummy Event']);
    final testBed = new NgTestBed<EventListTestComponent>().addProviders([
      provide(Router, useValue: router),
      provide(EventService, useValue: service),
    ]);
    final fixture = await testBed.create();

    // Create an instance of the in-browser page loader that uses our fixture.
    final loader = new HtmlPageLoader(fixture.element.parent, executeSyncedFn: (c) async {
      await c();
      return fixture.update;
    }, useShadowDom: false);

    // Get a handle to the list.
    final po = await loader.getInstance(EventListPO);
    final items = await po.items;
    expect(items, hasLength(1));
    expect(await items[0].visibleText, equals('Dummy Event'));
  });
}
