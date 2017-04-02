import 'dart:async';

import 'package:frontend/models/event.dart';
import 'package:frontend/models/sailing_club.dart';
import 'package:frontend/models/boat.dart';

// TODO: Should we have a percistency Interface that is segregated from the authentication interface?

abstract class PersistencyService {
//  final RegattaStore _store;

//  PersistencyService(this._store);

  Future signIn();
  void signOut();

  // These private methods are called by implementing classes
  // to propagate changes in the DB to the frontend.
/*
  void newEvent(Event newEvent) {
    _store.dispatch(actions.addEvent(newEvent));
  }

  void _changedEvent(Event changedEvent) {
    _store.dispatch(actions.updateEvent(changedEvent));
  }

  void _removedEvent(Event removedEvent) {
    _store.dispatch(actions.deleteEvent(removedEvent));
  }

  void _newSailingClub(SailingClub sc) {
    _store.dispatch(actions.addSailingClub(sc));
  }

  void _changedSailingClub(SailingClub sc) {
    _store.dispatch(actions.updateSailingClub(sc));
  }

  void _removedSailingClub(SailingClub sc) {
    _store.dispatch(actions.deleteSailingClub(sc));
  }

  void _newBoat(Boat boat) {
    _store.dispatch(actions.addBoat(boat));
  }

  void _changedBoat(Boat boat) {
    _store.dispatch(actions.updateBoat(boat));
  }

  void _removedBoat(Boat boat) {
    _store.dispatch(actions.deleteBoat(boat));
  }
*/
  // The following methods are called by the frontend
  // to write to the DB.

  Future addEvent(Event event);
  Future updateEvent(Event event);
  Future deleteEvent(Event event);

  Future addSailingClub(SailingClub sailingClub);
  Future updateSailingClub(SailingClub sailingClub);
  Future deleteSailingClub(SailingClub sailingClub);

  Future addBoat(Boat boat);
  Future updateBoat(Boat boat);
  Future deleteBoat(Boat boat);
}
