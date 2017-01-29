import 'package:angular2/core.dart';
import 'package:frontend/models/event.dart';

/// State of the regattaApp.
class RegattaState {
  /// All events available in the app.
  final Iterable<Event> events;

  /// Selected event
  final Event selectedEvent;

  /// Creates a new instance.
  RegattaState(Iterable<Event> events, Event selectedEvent)
      : this.events = events,
        this.selectedEvent = selectedEvent;

  /// Default state for the app, used when is not explicitly initialized.
  const RegattaState.initial()
      : this.events = const <Event>[],
        this.selectedEvent = null;

  /// Clones this instance
  RegattaState copy({Iterable<Event> events, Event selectedEvent}) =>
      new RegattaState(events ?? this.events, selectedEvent ?? this.selectedEvent);

  @override
  String toString() {
    return 'RegattaState{events: $events, selectedEvent: $selectedEvent}';
  }
}
