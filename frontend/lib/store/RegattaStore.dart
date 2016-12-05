import 'dart:async';
import 'package:angular2/core.dart';
import 'package:greencat/greencat.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/services/event_service.dart';
import 'package:frontend/app_component.dart';

enum ActionType { addEvent, addNewEvent }

/// Actions to be triggered to the app store.
abstract class RegattaAction<T> extends Action<ActionType> {
  /// The payload to include.
  @override
  final T payload;

  /// Creates a new instance.
  RegattaAction(this.payload);
}

/// Action to add an Event.
class AddEventAction extends RegattaAction<Event> {
  ///
  AddEventAction(Event payload) : super(payload);

  @override
  ActionType get type => ActionType.addEvent;
}

/// Action to request the add of a new Event.
class AddNewEventAction extends RegattaAction<String> implements AsyncAction {
  ///
  AddNewEventAction(String payload) : super(payload);

  @override
  ActionType get type => ActionType.addNewEvent;

  @override
  Future call(MiddlewareApi api) {
    EventService _event_service = AppComponent.myinjector.get(EventService);
    return _event_service.addEvent(payload).then((event) {
      api.dispatch(addEvent(event));
    });
  }
}

/// Utility function to trigger the addEvent action.
RegattaAction<Event> addEvent(Event event) => new AddEventAction(event);

/// Utility function to trigger the addEvent action.
RegattaAction<String> addNewEvent(String name) => new AddNewEventAction(name);

/// State of the regattaApp.
class RegattaState {
  /// Events available in the app.
  final Iterable<Event> events;

  /// Creates a new instance.
  RegattaState(Iterable<Event> events) : this.events = events;

  /// Default state for the app, used when is not explicitly initialized.
  const RegattaState.initial() : this.events = const <Event>[];

  /// Clones this instance
  RegattaState copy({Iterable<Event> events}) => new RegattaState(events ?? this.events);

  @override
  String toString() {
    return 'RegattaState{events: $events}';
  }
}

/// The reducer for the RegattaApp.
Reducer<RegattaState, RegattaAction<dynamic>> regattaApp =
    (RegattaAction<dynamic> action, {RegattaState currentState}) {
  if (currentState == null) {
    return new RegattaState.initial();
  }

  switch (action.type) {
    case ActionType.addEvent:
      print('Reducer: addEvent');
      final events = (new List<Event>.from(currentState.events)..add(action.payload)).toList(growable: false);
      return currentState.copy(events: events);
    case ActionType.addNewEvent:
      print('Reducer: addNewEvent');
      return currentState.copy();
    default:
      return currentState;
  }
};

@Injectable()
class RegattaStore {
  final EventService _eventService;
  var store;

  RegattaStore(this._eventService) {
    store = new Store.createStore(regattaApp);
    // The ThunkMiddleware adds async call capability to actions
    store.addMiddleware(new ThunkMiddleware<RegattaState, RegattaAction<dynamic>>());
    loadEvents();
  }

  Future<Null> loadEvents() async {
    print('loadevents start');
    final events = await _eventService.getEvents();
    for (var event in events) {
      print('dispatch');
      store.dispatch(addEvent(event));
      print(store.state);
    }
    print('loadevents end');
  }
}
