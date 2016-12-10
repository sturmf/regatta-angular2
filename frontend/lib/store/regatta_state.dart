import 'package:angular2/core.dart';
import 'package:frontend/models/event.dart';

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
