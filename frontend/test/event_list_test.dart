// Because Angular is using dart:html, we need these tests to run on an actual
// browser. This means that it should be run with `-p chrome` or `-p firefox`.
@TestOn('browser')

import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:test/test.dart';

import 'package:angular_router/angular_router.dart';
import 'package:mockito/mockito.dart';
import 'package:pageloader/html.dart';

import 'package:frontend/components/event_list_component/event_list_component.dart';
import 'package:frontend/components/event_list_component/event_list_component.template.dart' as ng;
import 'package:frontend/models/event.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/store/regatta_action.dart';
import 'page_objects/event_list_component_po.dart';

import 'event_list_test.template.dart' as self;
import 'utils.dart';

@GenerateInjector([
  ClassProvider(Router, useClass: MockRouter),
  ClassProvider(RegattaStore, useClass: MockRegattaStore),
  ClassProvider(RegattaActionHelper, useClass: MockRegattaActionHelper),
])
final InjectorFactory rootInjector = self.rootInjector$Injector;


void main() {
  final injector = InjectorProbe(rootInjector);
  final testBed = NgTestBed.forComponent<EventListComponent>(ng.EventListComponentNgFactory, rootInjector: injector.factory);
  NgTestFixture<EventListComponent> fixture;
  EventListComponentPO testPO;

  setUp(() async {
    /*
    fixture = await testBed.create();
    final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
    testPO = EventListComponentPO.create(context);
    */
  });

  tearDown(disposeAnyRunningTest);

  test('EventListComponent list contains dummy event', () async {
    final mockRegattaStore = injector.get<MockRegattaStore>(RegattaStore);
    final mockRegattaActionHelper = injector.get<MockRegattaActionHelper>(RegattaActionHelper);

    when(mockRegattaStore.state.events)
        .thenReturn({'-K2ib4H77rj0LYewF7dP': new Event('-K2ib4H77rj0LYewF7dP', 'Dummy Event')});
    when(mockRegattaStore.state.eventList).thenReturn(['-K2ib4H77rj0LYewF7dP']);
    when(mockRegattaStore.action).thenReturn(mockRegattaActionHelper);

    fixture = await testBed.create();
    final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
    testPO = EventListComponentPO.create(context);

    final items = testPO.items;
    expect(items, hasLength(1));

    final element = items[0].getElementsByCss('.event-item-name').first;
    expect(element.visibleText, equals('Dummy Event'));

    //regattaStore.close();
  });
}
