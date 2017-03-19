import 'dart:async';

import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:frontend/models/event.dart';
import 'package:frontend/models/sailing_club.dart';
import 'package:frontend/models/boat.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/store/regatta_action.dart' as actions;

@Injectable()
class FirebaseService {
  fb.Auth _fbAuth;
  fb.GoogleAuthProvider _fbGoogleAuthProvider;
  fb.Database _fbDatabase;
  // fb.Storage _fbStorage;
  fb.DatabaseReference _fbRefEvents;
  fb.DatabaseReference _fbRefSailingClubs;
  fb.DatabaseReference _fbRefBoats;
  fb.User user;

  final RegattaStore _store;

  FirebaseService(this._store) {
    fb.initializeApp(
      apiKey: "AIzaSyCJbyKGrg-eCBsycizN_wkRcpkbD9DXSbo",
      authDomain: "regatta-17147.firebaseapp.com",
      databaseURL: "https://regatta-17147.firebaseio.com",
      storageBucket: "regatta-17147.appspot.com",
    );
    // Set everything up for the auth service
    _fbGoogleAuthProvider = new fb.GoogleAuthProvider();
    _fbAuth = fb.auth();
    _fbAuth.onAuthStateChanged.listen(_authChanged);
    // Set everything up for the database service
    _fbDatabase = fb.database();
    _fbRefEvents = _fbDatabase.ref("events");
    _fbRefSailingClubs = _fbDatabase.ref("sailing_clubs");
    _fbRefBoats = _fbDatabase.ref("boats");
  }

  void _authChanged(fb.AuthEvent event) {
    user = event.user;
    if (user != null) {
      // FIXME: maybe send a clear event since the user might have changed
      _fbRefEvents.onChildAdded.listen(_newEvent);
      _fbRefEvents.onChildChanged.listen(_changedEvent);
      _fbRefEvents.onChildRemoved.listen(_removedEvent);

      _fbRefSailingClubs.onChildAdded.listen(_newSailingClub);
      _fbRefSailingClubs.onChildChanged.listen(_changedSailingClub);
      _fbRefSailingClubs.onChildRemoved.listen(_removedSailingClub);

      _fbRefBoats.onChildAdded.listen(_newBoat);
      _fbRefBoats.onChildChanged.listen(_changedBoat);
      _fbRefBoats.onChildRemoved.listen(_removedBoat);
    }
  }

  Future signIn() async {
    try {
      await _fbAuth.signInWithPopup(_fbGoogleAuthProvider);
    } catch (error) {
      print("$runtimeType::login() -- $error");
    }
  }

  void signOut() {
    _fbAuth.signOut();
  }

  void _newEvent(fb.QueryEvent event) {
    print("Event loaded ${event.snapshot.val()} ${event.snapshot.key}");
    final Event ev = new Event.fromMap(event.snapshot.key, event.snapshot.val());
    _store.dispatch(actions.addEvent(ev));
  }

  Future addEvent(Event event) async {
    try {
      await _fbRefEvents.push(event.toMap()).future;
    } catch (error) {
      print("$runtimeType::addEvent() -- $error");
    }
  }

  void _changedEvent(fb.QueryEvent event) {
    final Event ev = new Event.fromMap(event.snapshot.key, event.snapshot.val());
    _store.dispatch(actions.updateEvent(ev));
  }

  Future updateEvent(Event event) async {
    try {
      await _fbRefEvents.child(event.key).update(event.toMap());
    } catch (error) {
      print("$runtimeType::updateEvent() -- $error");
    }
  }

  void _removedEvent(fb.QueryEvent event) {
    final Event ev = new Event.fromMap(event.snapshot.key, event.snapshot.val());
    _store.dispatch(actions.deleteEvent(ev));
  }

  Future deleteEvent(Event event) async {
    try {
      await _fbRefEvents.child(event.key).remove();
    } catch (error) {
      print("$runtimeType::updateEvent() -- $error");
    }
  }

  void _newSailingClub(fb.QueryEvent event) {
    print("SailingClub loaded ${event.snapshot.val()} ${event.snapshot.key}");
    final SailingClub sc = new SailingClub.fromMap(event.snapshot.key, event.snapshot.val());
    _store.dispatch(actions.addSailingClub(sc));
  }

  Future addSailingClub(SailingClub sailingClub) async {
    try {
      await _fbRefSailingClubs.push(sailingClub.toMap()).future;
    } catch (error) {
      print("$runtimeType::addSailingClub() -- $error");
    }
  }

  void _changedSailingClub(fb.QueryEvent event) {
    final SailingClub sc = new SailingClub.fromMap(event.snapshot.key, event.snapshot.val());
    _store.dispatch(actions.updateSailingClub(sc));
  }

  Future updateSailingClub(SailingClub sailingClub) async {
    try {
      await _fbRefSailingClubs.child(sailingClub.key).update(sailingClub.toMap());
    } catch (error) {
      print("$runtimeType::updateSailingClub() -- $error");
    }
  }

  void _removedSailingClub(fb.QueryEvent event) {
    final SailingClub sc = new SailingClub.fromMap(event.snapshot.key, event.snapshot.val());
    _store.dispatch(actions.deleteSailingClub(sc));
  }

  Future deleteSailingClub(SailingClub sailingClub) async {
    try {
      await _fbRefSailingClubs.child(sailingClub.key).remove();
    } catch (error) {
      print("$runtimeType::updateSailingClub() -- $error");
    }
  }

  void _newBoat(fb.QueryEvent event) {
    print("Boat loaded ${event.snapshot.val()} ${event.snapshot.key}");
    final Boat sc = new Boat.fromMap(event.snapshot.key, event.snapshot.val());
    _store.dispatch(actions.addBoat(sc));
  }

  Future addBoat(Boat sailingClub) async {
    try {
      await _fbRefBoats.push(sailingClub.toMap()).future;
    } catch (error) {
      print("$runtimeType::addBoat() -- $error");
    }
  }

  void _changedBoat(fb.QueryEvent event) {
    final Boat sc = new Boat.fromMap(event.snapshot.key, event.snapshot.val());
    _store.dispatch(actions.updateBoat(sc));
  }

  Future updateBoat(Boat sailingClub) async {
    try {
      await _fbRefBoats.child(sailingClub.key).update(sailingClub.toMap());
    } catch (error) {
      print("$runtimeType::updateBoat() -- $error");
    }
  }

  void _removedBoat(fb.QueryEvent event) {
    final Boat sc = new Boat.fromMap(event.snapshot.key, event.snapshot.val());
    _store.dispatch(actions.deleteBoat(sc));
  }

  Future deleteBoat(Boat sailingClub) async {
    try {
      await _fbRefBoats.child(sailingClub.key).remove();
    } catch (error) {
      print("$runtimeType::updateBoat() -- $error");
    }
  }
}
