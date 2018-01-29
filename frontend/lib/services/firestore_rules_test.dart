@TestOn('browser')
import "dart:async";
import "dart:convert";
import 'package:http/browser_client.dart' as http;
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:test/test.dart';

Map<String, String> _config;

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
    _config = JSON.decode(jsonString) as Map<String, String>;
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

Future<fb.User> signIn(fb.App app, String user, String password) {
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
    final fb.User alice = await signIn(_app, _config['USER_ALICE_EMAIL'], _config['USER_ALICE_PASSWORD']);
    expect(alice.uid, isNotNull);
    final fb.User bob = await signIn(_app, _config['USER_BOB_EMAIL'], _config['USER_BOB_PASSWORD']);
    expect(bob.uid, isNotNull);
  });

  test('Alice can create and update a sailing club but not delete', () async {
    final fb.User alice = await signIn(_app, _config['USER_ALICE_EMAIL'], _config['USER_ALICE_PASSWORD']);
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

  test('Alice can create sailing club but bob cant update or delete', () async {
    final fb.User alice = await signIn(_app, _config['USER_ALICE_EMAIL'], _config['USER_ALICE_PASSWORD']);
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
    await signIn(_app, _config['USER_BOB_EMAIL'], _config['USER_BOB_PASSWORD']);
    // Update
    expect(sailingClub.set({"name": "a test updated"}, new fs.SetOptions(merge: true)),
        throwsToString(contains('Missing or insufficient permissions')));
    // Delete
    expect(sailingClub.delete(), throwsToString(contains('Missing or insufficient permissions')));
  });

  // Alice can make Bob an admin of a sailing club she is admin of but Bob cant
}
