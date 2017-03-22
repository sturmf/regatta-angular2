// Because Angular is using dart:html, we need these tests to run on an actual
// browser. This means that it should be run with `-p dartium` or `-p chrome`.
@TestOn('browser')
import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:test/test.dart';

import 'package:angular2/router.dart';
import 'package:mockito/mockito.dart';

import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/components/event_list_component/event_list_component.dart';
import 'package:frontend/components/event_list_component/event_list_component_po.dart';
import 'package:frontend/models/event.dart';

// We have to wrap our component in a slim wrapper to resolve it with getInstance later
@Component(selector: 'test', directives: const [EventListComponent], template: '<my-event-list></my-event-list>')
class EventListTestComponent {}

@AngularEntrypoint()
void main() {
  tearDown(disposeAnyRunningTest);

  test('EventListComponent list contains dummy event', () async {
    final router = new MockRouter();
    final regattaStore = new MockRegattaStore();

    when(regattaStore.state.events).thenReturn({1: new Event('-K2ib4H77rj0LYewF7dP', 'Dummy Event')});

    final testBed = new NgTestBed<EventListTestComponent>().addProviders([
      provide(Router, useValue: router),
      provide(RegattaStore, useValue: regattaStore),
    ]);

    final fixture = await testBed.create();

    // Get a handle to the list.
    final pageObject = await fixture.resolvePageObject/*<EventListPO>*/(
      EventListPO,
    );

    final items = await pageObject.items;
    expect(items, hasLength(1));
    expect(await items[0].visibleText, equals('Dummy Event'));

    regattaStore.close();
  });
}
