import 'dart:async';

import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart' as fb;

@Injectable()
class FirebaseService {
  fb.Auth _fbAuth;
  fb.GoogleAuthProvider _fbGoogleAuthProvider;
  // fb.Database _fbDatabase;
  // fb.Storage _fbStorage;
  // fb.DatabaseReference _fbRefMessages;
  fb.User user;

  FirebaseService() {
    fb.initializeApp(
      apiKey: "AIzaSyCJbyKGrg-eCBsycizN_wkRcpkbD9DXSbo",
      authDomain: "regatta-17147.firebaseapp.com",
      databaseURL: "https://regatta-17147.firebaseio.com",
      storageBucket: "regatta-17147.appspot.com",
    );
    _fbGoogleAuthProvider = new fb.GoogleAuthProvider();
    _fbAuth = fb.auth();
    _fbAuth.onAuthStateChanged.listen(_authChanged);
  }

  void _authChanged(fb.AuthEvent event) {
    user = event.user;
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
}
