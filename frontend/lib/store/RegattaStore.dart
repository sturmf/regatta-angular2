import 'package:angular2/core.dart';
import 'package:greencat/greencat.dart';
import 'package:frontend/models/event.dart';


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

/// Action to add an Event.
class AddEventAction extends RegattaAction<String> {
  ///
  AddEventAction(String payload) : super(payload);

  @override
  ActionType get type => ActionType.addEvent;
}

/// Utility function to trigger the addEvent action.
RegattaAction<String> addEventX(String description) => new AddEventAction(description);

/// State of the regattaApp.
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

  print('before switch');
  print('Action: $action');

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

@Injectable()
class RegattaStore {
  var store;
  RegattaStore() {
    store = new Store.createStore(regattaApp);
  }
}


