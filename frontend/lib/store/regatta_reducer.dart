import 'action_type.dart';
import 'regatta_action.dart';
import 'regatta_state.dart';
import 'package:greencat/greencat.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/models/sailing_club.dart';
import 'package:frontend/models/boat.dart';

/// The reducer for the RegattaApp.
Reducer<RegattaState, RegattaAction<dynamic>> regattaApp =
    (RegattaAction<dynamic> action, {RegattaState currentState}) {
  if (currentState == null) {
    return new RegattaState.initial();
  }

  switch (action.type) {
    case ActionType.addEvent:
      final events = new Map<String, Event>.from(currentState.events);
      events[action.payload.key] = action.payload;
      return currentState.copy(events: events);
    case ActionType.updateEvent:
      final events = new Map<String, Event>.from(currentState.events);
      events[action.payload.key] = action.payload;
      return currentState.copy(events: events);
    case ActionType.deleteEvent:
      final events = new Map<String, Event>.from(currentState.events);
      events.remove(action.payload.key);
      return currentState.copy(events: events);

    case ActionType.addSailingClub:
      final sailingClubs = new Map<String, SailingClub>.from(currentState.sailingClubs);
      sailingClubs[action.payload.key] = action.payload;
      return currentState.copy(sailingClubs: sailingClubs);
    case ActionType.updateSailingClub:
      final sailingClubs = new Map<String, SailingClub>.from(currentState.sailingClubs);
      sailingClubs[action.payload.key] = action.payload;
      return currentState.copy(sailingClubs: sailingClubs);
    case ActionType.deleteSailingClub:
      final sailingClubs = new Map<String, SailingClub>.from(currentState.sailingClubs);
      sailingClubs.remove(action.payload.key);
      return currentState.copy(sailingClubs: sailingClubs);

    case ActionType.addBoat:
      final boats = new Map<String, Boat>.from(currentState.boats);
      boats[action.payload.key] = action.payload;
      return currentState.copy(boats: boats);
    case ActionType.updateBoat:
      final boats = new Map<String, Boat>.from(currentState.boats);
      boats[action.payload.key] = action.payload;
      return currentState.copy(boats: boats);
    case ActionType.deleteBoat:
      final boats = new Map<String, Boat>.from(currentState.boats);
      boats.remove(action.payload.key);
      return currentState.copy(boats: boats);

    default:
      return currentState;
  }
};
