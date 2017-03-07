import 'package:angular2/core.dart';
import 'package:frontend/models/event.dart';

/// State of the regattaApp.
class RegattaState {
  /// All events available in the app.
  final Map<String, Event> events;

  /// Creates a new instance.
  RegattaState(Map<String, Event> events) : this.events = new Map.from(events);

  /// Default state for the app, used when is not explicitly initialized.
  RegattaState.initial() : this.events = <String, Event>{};

  /// Clones this instance
  RegattaState copy({Map<String, Event> events}) => new RegattaState(events ?? this.events);

  @override
  String toString() {
    return 'RegattaState{events: $events}';
  }
}
