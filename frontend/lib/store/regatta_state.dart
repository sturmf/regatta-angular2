import 'package:frontend/models/event.dart';
import 'package:frontend/models/person.dart';
import 'package:frontend/models/sailing_club.dart';
import 'package:frontend/models/boat.dart';

/// State of the regattaApp.
class RegattaState {
  /// The currently logged in person
  final Person currentUser;

  /// All entities available in the app.
  final Map<String, Event> events;
  final List<String> eventList;
  final Map<String, SailingClub> sailingClubs;
  final Map<String, Boat> boats;

  //static const _noValueGiven = const Object();

  /// Creates a new instance.
  RegattaState(Person currentUser, Map<String, Event> events, List<String> eventList,
      Map<String, SailingClub> sailingClubs, Map<String, Boat> boats)
      : this.currentUser = currentUser,
        this.events = new Map.from(events),
        this.eventList = new List.from(eventList),
        this.sailingClubs = new Map.from(sailingClubs),
        this.boats = new Map.from(boats);

  /// Default state for the app, used when is not explicitly initialized.
  RegattaState.initial()
      : this.currentUser = null,
        this.events = <String, Event>{},
        this.eventList = [],
        this.sailingClubs = <String, SailingClub>{},
        this.boats = <String, Boat>{};

  /// Clones this instance
  RegattaState copy(
          {Person currentUser, // FIXME: this way reset must pass a Person with id == "" to reset
          Map<String, Event> events,
          List<String> eventList,
          Map<String, SailingClub> sailingClubs,
          Map<String, Boat> boats}) =>
      new RegattaState(currentUser != null ? (currentUser.id == "" ? null : currentUser) : this.currentUser,
          events ?? this.events, eventList ?? this.eventList, sailingClubs ?? this.sailingClubs, boats ?? this.boats);

  @override
  String toString() {
    return 'RegattaState{currentUser: $currentUser, events: $events, sailingClubs: $sailingClubs, boats: $boats}';
  }
}
