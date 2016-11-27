import 'package:angular2/core.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';
import 'package:greencat/greencat.dart';

import 'package:frontend/models/event.dart';
import 'event_list_component.dart';
import 'event_detail_component.dart';
import 'package:frontend/services/event_service.dart';
import 'package:frontend/services/sailing_club_service.dart';
import 'package:frontend/services/person_service.dart';
import 'package:frontend/navigation_bar_component.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    directives: const [ROUTER_DIRECTIVES, NavigationBarComponent],
    providers: const [
      ROUTER_PROVIDERS,
      const Provider(LocationStrategy, useClass: HashLocationStrategy),
      EventService,
      SailingClubService,
      PersonService
    ],
    changeDetection: ChangeDetectionStrategy.OnPush)
@RouteConfig(const [
  const Route(path: '/events', name: 'Events', component: EventListComponent, useAsDefault: true),
  const Route(path: '/event/:id', name: 'EventDetail', component: EventDetailComponent)
])
class AppComponent implements OnInit, OnDestroy {
  // Store
  final Store<RegattaState, RegattaAction> store = new Store.createStore(regattaApp);

  @override
  void ngOnDestroy() {
    store.close();
  }

  @override
  void ngOnInit() {
    print(store.state);
    store.dispatch(addEvent('test event'));
    print(store.state);
  }

}


enum ActionType {
  addEvent
}

/// Actions to be triggered to the app store.
abstract class RegattaAction<T> extends Action<ActionType> {
  /// The payload to include.
  @override
  final T payload;

  /// Creates a new instance.
  RegattaAction(this.payload);
}

/// Utility function to trigger the addEvent action.
RegattaAction<String> addEvent(String description) =>
    new AddEventAction(description);

/// Action to add a to do.
class AddEventAction extends RegattaAction<String> {
  ///
  AddEventAction(String payload) : super(payload);

  @override
  ActionType get type => ActionType.addEvent;
}

/// State for the regattaApp.
class RegattaState {

  /// Events available in the app.
  final Iterable<Event> events;

  /// Creates a new instance.
  RegattaState(Iterable<Event> events)
      : this.events = events;

  /// Default state for the app, used when is not explicitly initialized.
  const RegattaState.initial()
      : this.events = const <Event>[];

  /// Clones this instance
  RegattaState copy({Iterable<Event> events}) =>
      new RegattaState(events ?? this.events);
/*
  /// Converts the state to a tuple.
  Tuple2<Iterable<Todo>, VisibilityFilter> toTuple() =>
      new Tuple2(todos, filter);
*/
  @override
  String toString() {
    return 'RegattaState{events: $events}';
  }
}


/// The reducer for the TodoApp.
Reducer<RegattaState, RegattaAction<dynamic>> regattaApp =
    (RegattaAction<dynamic> action, {RegattaState currentState}) {
  if (currentState == null) {
    return new RegattaState.initial();
  }

  switch (action.type) {
    case ActionType.addEvent:
      final events = (new List<Event>.from(currentState.events)
            ..add(new Event(1, action.payload)))
          .toList(growable: false);
      return currentState.copy(events: events);
    default:
      return currentState;
  }
};
