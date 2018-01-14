import 'dart:async';

import 'package:angular/angular.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:frontend/models/event.dart';
import 'package:frontend/models/person.dart';
import 'package:frontend/models/sailing_club.dart';
import 'package:frontend/models/boat.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/store/regatta_action.dart' as actions;

@Injectable()
class FirebaseService {
  fb.Auth _fbAuth;
  fb.GoogleAuthProvider _fbGoogleAuthProvider;
  fb.User user;

  // References to the different firebase functionallities
  fs.Firestore _fbStore;
  // fb.Storage _fbStorage;
  // fb.Database _fbDatabase;

  // Our firestore collections
  fs.CollectionReference _fsRefEvents;
  fs.CollectionReference _fsRefSailingClubs;
  fs.CollectionReference _fsRefBoats;

  final RegattaStore _store;

  FirebaseService(this._store) {
    fb.initializeApp(
      apiKey: "AIzaSyCJbyKGrg-eCBsycizN_wkRcpkbD9DXSbo",
      authDomain: "regatta-17147.firebaseapp.com",
      databaseURL: "https://regatta-17147.firebaseio.com",
      projectId: "regatta-17147",
      storageBucket: "regatta-17147.appspot.com",
    );
    _initalize_authentication();
    _subscribe_to_firestore_collections();
  }

  void _initalize_authentication() {
    _fbGoogleAuthProvider = new fb.GoogleAuthProvider();
    _fbAuth = fb.auth();
    _fbAuth.onAuthStateChanged.listen(_authChanged);
  }

  void _subscribe_to_firestore_collections() {
    _fbStore = fb.firestore();
    _fsRefEvents = _fbStore.collection("events");
    _fsRefEvents.onSnapshot.listen(_eventChanges);
    _fsRefSailingClubs = _fbStore.collection("sailing_clubs");
    _fsRefSailingClubs.onSnapshot.listen(_sailingClubChanges);
    _fsRefBoats = _fbStore.collection("boats");
    _fsRefBoats.onSnapshot.listen(_boatChanges);
  }

  void _authChanged(fb.User user) {
    this.user = user;
    if (user != null) {
      // FIXME: we actually should load the persons profile here which contains e.g. first and lastnamme
      _store.dispatch(actions.loginChanged(new Person(user.uid, "", user.displayName)));
    } else {
      _store.dispatch(actions.loginChanged(null));
    }
  }

  // The following methods all react to changes in firebase and emits actions

  void _eventChanges(fs.QuerySnapshot querySnapshot) {
    querySnapshot.docChanges.forEach((change) {
      final Event ev = new Event.fromMap(change.doc.ref.id, change.doc.data());
      switch (change.type) {
        case "added":
          _store.dispatch(actions.addEvent(ev));
          break;
        case "removed":
          _store.dispatch(actions.deleteEvent(ev));
          break;
        case "modified":
          _store.dispatch(actions.updateEvent(ev));
          break;
      }
    });
  }

  void _sailingClubChanges(fs.QuerySnapshot querySnapshot) {
    querySnapshot.docChanges.forEach((change) {
      final SailingClub sc = new SailingClub.fromMap(change.doc.ref.id, change.doc.data());
      switch (change.type) {
        case "added":
          _store.dispatch(actions.addSailingClub(sc));
          break;
        case "removed":
          _store.dispatch(actions.deleteSailingClub(sc));
          break;
        case "modified":
          _store.dispatch(actions.updateSailingClub(sc));
          break;
      }
    });
  }

  void _boatChanges(fs.QuerySnapshot querySnapshot) {
    querySnapshot.docChanges.forEach((change) {
      final Boat boat = new Boat.fromMap(change.doc.ref.id, change.doc.data());
      switch (change.type) {
        case "added":
          _store.dispatch(actions.addBoat(boat));
          break;
        case "removed":
          _store.dispatch(actions.deleteBoat(boat));
          break;
        case "modified":
          _store.dispatch(actions.updateBoat(boat));
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

  Future addEvent(Event event) async {
    try {
      await _fsRefEvents.add(event.toMap());
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
      print("$runtimeType::updateEvent() -- $error");
    }
  }

  Future addSailingClub(SailingClub sailingClub, {Person initialAdmin}) async {
    try {
      final sc = sailingClub.toMap();
      sc['admins'] = {initialAdmin.id: true};
      await _fsRefSailingClubs.add(sc);
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
      print("$runtimeType::updateSailingClub() -- $error");
    }
  }

  Future addBoat(Boat boat) async {
    try {
      await _fsRefBoats.add(boat.toMap());
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
      print("$runtimeType::updateBoat() -- $error");
    }
  }
}
