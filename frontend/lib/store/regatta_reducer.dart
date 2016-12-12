import 'action_type.dart';
import 'regatta_action.dart';
import 'regatta_state.dart';
import 'package:angular2/core.dart';
import 'package:greencat/greencat.dart';
import 'package:frontend/models/event.dart';

/// The reducer for the RegattaApp.
Reducer<RegattaState, RegattaAction<dynamic>> regattaApp =
    (RegattaAction<dynamic> action, {RegattaState currentState}) {
  if (currentState == null) {
    return new RegattaState.initial();
  }

  switch (action.type) {
    case ActionType.addEvent:
      final events = (new List<Event>.from(currentState.events)..add(action.payload)).toList(growable: false);
      return currentState.copy(events: events);
    case ActionType.deleteEvent:
      final events = currentState.events.where((event) => event != action.payload).toList(growable: false);
      return currentState.copy(events: events);
    default:
      return currentState;
  }
};
