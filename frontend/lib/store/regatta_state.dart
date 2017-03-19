import 'package:angular2/core.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/models/sailing_club.dart';

/// State of the regattaApp.
class RegattaState {
  /// All events available in the app.
  final Map<String, Event> events;
  final Map<String, SailingClub> sailingClubs;

  /// Creates a new instance.
  RegattaState(Map<String, Event> events, Map<String, SailingClub> sailingClubs)
      : this.events = new Map.from(events),
        this.sailingClubs = new Map.from(sailingClubs);

  /// Default state for the app, used when is not explicitly initialized.
  RegattaState.initial()
      : this.events = <String, Event>{},
        this.sailingClubs = <String, SailingClub>{};

  /// Clones this instance
  RegattaState copy({Map<String, Event> events, Map<String, SailingClub> sailingClubs}) =>
      new RegattaState(events ?? this.events, sailingClubs ?? this.sailingClubs);

  @override
  String toString() {
    return 'RegattaState{events: $events, sailingClubs: $sailingClubs}';
  }
}
