@TestOn('browser')
import "dart:async";
import "dart:convert";
import 'package:http/browser_client.dart' as http;
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:test/test.dart';

Map<String, dynamic> _config;

// This is necessary to read the config values from a file,
// since we are browser based we can't use dart:io
Future config() async {
  final client = new http.BrowserClient();

  try {
    final response = await client.get('packages/frontend/services/config.json');
    if (response.statusCode > 399) {
      throw new StateError("Problem with server: ${response.statusCode} ${response.body}");
    }

    final jsonString = response.body;
    _config = JSON.decode(jsonString) as Map<String, dynamic>;
  } catch (e) {
    print("Error getting `config.json`. Make sure it exists.");
    rethrow;
  } finally {
    client.close();
  }
}

Matcher throwsToString(dynamic value) => throwsA(new _ToStringMatcher(value));

class _ToStringMatcher extends CustomMatcher {
  _ToStringMatcher(matcher) : super("Object toString value", "toString", matcher);

  @override
  String featureValueOf(dynamic actual) => actual.toString();
}

Future<fb.User> signIn(fb.App app, String user, String password) async {
  if (app.auth().currentUser != null) {
    await app.auth().signOut();
  }
  return app.auth().signInWithEmailAndPassword(user, password);
}

void main() {
  fb.App _app;
  fs.Firestore _fbStore;

  setUpAll(() async {
    await config();
  });

  setUp(() async {
    _app = fb.initializeApp(
        apiKey: _config['API_KEY'],
        authDomain: _config['AUTH_DOMAIN'],
        databaseURL: _config['DATABASE_URL'],
        projectId: _config['PROJECT_ID'],
        storageBucket: _config['STORAGE_BUCKET']);
    _fbStore = fb.firestore();
  });

  tearDown(() async {
    if (_app != null) {
      await _app.delete();
      _app = null;
    }
  });

  test('Alice and bob can sign in', () async {
    final fb.User alice = await signIn(_app, _config['USER']['ALICE']['EMAIL'], _config['USER']['ALICE']['PASSWORD']);
    expect(_app.auth().currentUser, isNotNull);
    expect(alice.uid, isNotNull);
    final fb.User bob = await signIn(_app, _config['USER']['BOB']['EMAIL'], _config['USER']['BOB']['PASSWORD']);
    expect(_app.auth().currentUser, isNotNull);
    expect(bob.uid, isNotNull);
  });

  test('Alice can create and update a sailing club but not delete', () async {
    final fb.User alice = await signIn(_app, _config['USER']['ALICE']['EMAIL'], _config['USER']['ALICE']['PASSWORD']);
    final fs.CollectionReference _fsRefSailingClubs = _fbStore.collection("sailing_clubs");
    // Create
    final Map<String, dynamic> sailingClubMap = {'name': 'a test'};
    sailingClubMap['roles'] = {alice.uid: 'owner'};
    final sailingClub = await _fsRefSailingClubs.add(sailingClubMap);
    expect(sailingClub.id, isNotNull);
    var snapshot = await sailingClub.get();
    expect(snapshot.exists, isTrue);
    expect(snapshot.data()['name'], 'a test');
    // Update
    await sailingClub.set({"name": "a test updated"}, new fs.SetOptions(merge: true));
    snapshot = await sailingClub.get();
    expect(snapshot.exists, isTrue);
    expect(snapshot.data()['name'], 'a test updated');
    // Delete
    expect(sailingClub.delete(), throwsToString(contains('Missing or insufficient permissions')));
  });

  test('Alice can create sailing club but Bob cant update or delete', () async {
    final fb.User alice = await signIn(_app, _config['USER']['ALICE']['EMAIL'], _config['USER']['ALICE']['PASSWORD']);
    final fs.CollectionReference _fsRefSailingClubs = _fbStore.collection("sailing_clubs");
    // Create
    final Map<String, dynamic> sailingClubMap = {'name': 'a test'};
    sailingClubMap['roles'] = {alice.uid: 'owner'};
    final sailingClub = await _fsRefSailingClubs.add(sailingClubMap);
    expect(sailingClub.id, isNotNull);
    final snapshot = await sailingClub.get();
    expect(snapshot.exists, isTrue);
    expect(snapshot.data()['name'], 'a test');
    // Login as Bob
    await signIn(_app, _config['USER']['BOB']['EMAIL'], _config['USER']['BOB']['PASSWORD']);
    // Update
    await expectLater(sailingClub.set({"name": "a test updated"}, new fs.SetOptions(merge: true)),
        throwsToString(contains('Missing or insufficient permissions')));
    // Delete
    expect(sailingClub.delete(), throwsToString(contains('Missing or insufficient permissions')));
  });

  test('Alice can make Bob an owner of a sailing club she is owner of but Bob cant himself', () async {
    fb.User alice = await signIn(_app, _config['USER']['ALICE']['EMAIL'], _config['USER']['ALICE']['PASSWORD']);
    final fs.CollectionReference _fsRefSailingClubsAlice = _fbStore.collection("sailing_clubs");
    // Create
    final Map<String, dynamic> sailingClubMap = {'name': 'a test with second owner'};
    sailingClubMap['roles'] = {alice.uid: 'owner'};
    final sailingClubAlice = await _fsRefSailingClubsAlice.add(sailingClubMap);
    // Switch to Bob and try to make himself an owner
    final fb.User bob = await signIn(_app, _config['USER']['BOB']['EMAIL'], _config['USER']['BOB']['PASSWORD']);
    final fs.CollectionReference _fsRefSailingClubsBob = _fbStore.collection("sailing_clubs");
    final fs.DocumentReference sailingClubBob = _fsRefSailingClubsBob.doc(sailingClubAlice.id);
    await expectLater(
        sailingClubBob.set({
          "roles": {bob.uid: 'owner'}
        }, new fs.SetOptions(merge: true)),
        throwsToString(contains('Missing or insufficient permissions')));
    // Switch to Alice and try to make Bob an owner
    alice = await signIn(_app, _config['USER']['ALICE']['EMAIL'], _config['USER']['ALICE']['PASSWORD']);
    final fs.CollectionReference _fsRefSailingClubsAlice2 = _fbStore.collection("sailing_clubs");
    final fs.DocumentReference sailingClubAlice2 = _fsRefSailingClubsAlice2.doc(sailingClubAlice.id);
    await sailingClubAlice2.set({
      "roles": {bob.uid: 'owner'}
    }, new fs.SetOptions(merge: true));
    final snapshot = await sailingClubAlice2.get();
    expect(snapshot.data()['roles'][alice.uid], 'owner');
    expect(snapshot.data()['roles'][bob.uid], 'owner');
  });
}
