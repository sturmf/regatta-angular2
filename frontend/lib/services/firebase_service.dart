import 'dart:async';

import 'package:angular/angular.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:frontend/models/event.dart';
import 'package:frontend/models/person.dart';
import 'package:frontend/models/sailing_club.dart';
import 'package:frontend/models/boat.dart';
import 'package:frontend/store/regatta_store.dart';

@Injectable()
class FirebaseService {
  fb.Auth _fbAuth;
  fb.GoogleAuthProvider _fbGoogleAuthProvider;
  fb.User user;

  // References to the different firebase functionalities
  fs.Firestore _fbStore;
  // fb.Storage _fbStorage;
  // fb.Database _fbDatabase;

  // Our firestore collections
  fs.CollectionReference _fsRefEvents;
  fs.CollectionReference _fsRefSailingClubs;
  fs.CollectionReference _fsRefBoats;

  List _filterList = [];
  final int _pageSize = 10;
  final RegattaStore _store;

  FirebaseService(this._store) {
    fb.initializeApp(
      apiKey: "AIzaSyCa1wbhvXQwemdEVCxeXxQfYe9SUM4SJWk",
      authDomain: "regatta-204708.firebaseapp.com",
      databaseURL: "https://regatta-204708.firebaseio.com",
      projectId: "regatta-204708",
      storageBucket: "regatta-204708.appspot.com",
    );
    _initalizeAuthentication();
    _subscribeToFirestoreCollections();
  }

  void _initalizeAuthentication() {
    _fbGoogleAuthProvider = new fb.GoogleAuthProvider();
    _fbAuth = fb.auth();
    _fbAuth.onAuthStateChanged.listen(_authChanged);
  }

  void _subscribeToFirestoreCollections() {
    _fbStore = fb.firestore();
    _fsRefEvents = _fbStore.collection("events");
    _fsRefSailingClubs = _fbStore.collection("sailing_clubs");
    _fsRefSailingClubs.onSnapshot.listen(_sailingClubChanges);
    _fsRefBoats = _fbStore.collection("boats");
    _fsRefBoats.onSnapshot.listen(_boatChanges);
  }

  void _authChanged(fb.User user) {
    this.user = user;
    if (user != null) {
      // FIXME: we actually should load the persons profile here which contains e.g. first and lastnamme
      _store.dispatch(_store.action.loginChanged(new Person(user.uid, "", user.displayName)));
    } else {
      _store.dispatch(_store.action.loginChanged(null));
    }
  }

  // The following methods all react to changes in firebase and emit actions

  /*
  void _eventChanges(fs.QuerySnapshot querySnapshot) {
    querySnapshot.docChanges.forEach((change) {
      final Event ev = new Event.fromMap(change.doc.ref.id, change.doc.data());
      switch (change.type) {
        case "added":
          _store.dispatch(_store.action.addEvent(ev));
          break;
        case "removed":
          _store.dispatch(_store.action.deleteEvent(ev));
          break;
        case "modified":
          _store.dispatch(_store.action.updateEvent(ev));
          break;
      }
    });
  }
  */

  void _sailingClubChanges(fs.QuerySnapshot querySnapshot) {
    querySnapshot.docChanges.forEach((change) {
      final SailingClub sc = new SailingClub.fromMap(change.doc.ref.id, change.doc.data());
      switch (change.type) {
        case "added":
          _store.dispatch(_store.action.addSailingClub(sc));
          break;
        case "removed":
          _store.dispatch(_store.action.deleteSailingClub(sc));
          break;
        case "modified":
          _store.dispatch(_store.action.updateSailingClub(sc));
          break;
      }
    });
  }

  void _boatChanges(fs.QuerySnapshot querySnapshot) {
    querySnapshot.docChanges.forEach((change) {
      final Boat boat = new Boat.fromMap(change.doc.ref.id, change.doc.data());
      switch (change.type) {
        case "added":
          _store.dispatch(_store.action.addBoat(boat));
          break;
        case "removed":
          _store.dispatch(_store.action.deleteBoat(boat));
          break;
        case "modified":
          _store.dispatch(_store.action.updateBoat(boat));
          break;
      }
    });
  }

  // The following methods all react to local input and forwards it to firebase

  Future signIn() async {
    try {
      await _fbAuth.signInWithPopup(_fbGoogleAuthProvider);
    } catch (error) {
      print("$runtimeType::login() -- $error");
    }
  }

  Future signOut() async {
    try {
      await _fbAuth.signOut();
    } catch (error) {
      print("$runtimeType::signOut() -- $error");
    }
  }

  Future _loadEvents(String startingEvent, String direction) async {
    fs.QuerySnapshot events;
    fs.Query eventsRef;
    final List<String> eventList = new List();

    // Create the query depending on input
    eventsRef = _fsRefEvents.orderBy('start_date', direction).orderBy('name', direction);
    eventsRef = eventsRef.limit(_pageSize);
    // If we have a starting event, load it and start query with it
    if (startingEvent != null) {
      final le = await _fsRefEvents.doc(startingEvent).get();
      eventsRef = eventsRef.startAfter(snapshot: le);
    }
    // Add filter terms
    for (var term in _filterList) {
      eventsRef = eventsRef.where('name', '==', term);
    }

    // Now execute query
    events = await eventsRef.get();

    // Send all received events
    for (var snapshot in events.docs) {
      final Event ev = new Event.fromMap(snapshot.ref.id, snapshot.data());
      eventList.add(ev.key);
      _store.dispatch(_store.action.addEvent(ev));
    }
    // only update list of selected events if it is not empty, reversed if descending
    if (eventList.isNotEmpty) {
      _store.dispatch(_store.action.selectedEvents(direction == 'asc' ? eventList : eventList.reversed));
    }
  }

  Future filterEvents(String filter) async {
    _filterList = filter.trim().split(new RegExp(r"\s+"));
    return nextEvents(null);
  }

  Future previousEvents(String firstEvent) async {
    await _loadEvents(firstEvent, 'desc');
  }

  Future nextEvents(String lastEvent) async {
    await _loadEvents(lastEvent, 'asc');
  }

  Future createEvent(Event event) async {
    try {
      final _event = event.toMap();
      _event['roles'] = {_store.state.currentUser.id: 'owner'};
      final newEventRef = await _fsRefEvents.add(_event);
      final snapshot = await newEventRef.get();
      final Event newEvent = new Event.fromMap(snapshot.id, snapshot.data());
      _store.dispatch(_store.action.addEvent(newEvent));
      _store.dispatch(_store.action.eventCreated(newEvent));
    } catch (error) {
      print("$runtimeType::addEvent() -- $error");
    }
  }

  Future updateEvent(Event event) async {
    try {
      await _fsRefEvents.doc(event.key).update(data: event.toMap());
    } catch (error) {
      print("$runtimeType::updateEvent() -- $error");
    }
  }

  Future deleteEvent(Event event) async {
    try {
      await _fsRefEvents.doc(event.key).delete();
    } catch (error) {
      print("$runtimeType::deleteEvent() -- $error");
    }
  }

  Future addSailingClub(SailingClub sailingClub) async {
    try {
      final _sailingClub = sailingClub.toMap();
      _sailingClub['roles'] = {_store.state.currentUser.id: 'owner'};
      await _fsRefSailingClubs.add(_sailingClub);
    } catch (error) {
      print("$runtimeType::addSailingClub() -- $error");
    }
  }

  Future updateSailingClub(SailingClub sailingClub) async {
    try {
      await _fsRefSailingClubs.doc(sailingClub.key).update(data: sailingClub.toMap());
    } catch (error) {
      print("$runtimeType::updateSailingClub() -- $error");
    }
  }

  Future deleteSailingClub(SailingClub sailingClub) async {
    try {
      await _fsRefSailingClubs.doc(sailingClub.key).delete();
    } catch (error) {
      print("$runtimeType::deleteSailingClub() -- $error");
    }
  }

  Future addBoat(Boat boat) async {
    try {
      final _boat = boat.toMap();
      _boat['roles'] = {_store.state.currentUser.id: 'owner'};
      await _fsRefBoats.add(_boat);
    } catch (error) {
      print("$runtimeType::addBoat() -- $error");
    }
  }

  Future updateBoat(Boat boat) async {
    try {
      await _fsRefBoats.doc(boat.key).update(data: boat.toMap());
    } catch (error) {
      print("$runtimeType::updateBoat() -- $error");
    }
  }

  Future deleteBoat(Boat boat) async {
    try {
      await _fsRefBoats.doc(boat.key).delete();
    } catch (error) {
      print("$runtimeType::deleteBoat() -- $error");
    }
  }
}
