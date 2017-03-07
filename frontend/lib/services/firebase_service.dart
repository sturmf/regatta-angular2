import 'dart:async';

import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:frontend/models/event.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/store/regatta_action.dart' as actions;

@Injectable()
class FirebaseService {
  fb.Auth _fbAuth;
  fb.GoogleAuthProvider _fbGoogleAuthProvider;
  fb.Database _fbDatabase;
  // fb.Storage _fbStorage;
  fb.DatabaseReference _fbRefEvents;
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
  }

  void _authChanged(fb.AuthEvent event) {
    user = event.user;
    if (user != null) {
      // FIXME: maybe send a clear event since the user might have changed
      _fbRefEvents.onChildAdded.listen(_newEvent);
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
    print("Event loaded ${event.snapshot}");
    final Event ev = new Event.fromMap(event.snapshot.val());
    _store.dispatch(actions.addEvent(ev));
  }

  Future addEvent(Event event) async {
    try {
      await _fbRefEvents.push(event.toMap()).future;
    }
    catch (error) {
      print("$runtimeType::addEvent() -- $error");
    }
  }
}
