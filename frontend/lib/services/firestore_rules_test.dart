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

void main() {
  fb.App app;
  fb.User user;

  setUpAll(() async {
    await config();
  });

  setUp(() async {
    app = fb.initializeApp(
        apiKey: _config['API_KEY'],
        authDomain: _config['AUTh_DOMAIN'],
        databaseURL: _config['DATABASE_URL'],
        projectId: _config['PROJECT_ID'],
        storageBucket: _config['STORAGE_BUCKET']);

    user = await app.auth().signInWithEmailAndPassword(_config['USER_ALICE_EMAIL'], _config['USER_ALICE_PASSWORD']);
  });

  tearDown(() async {
    if (app != null) {
      await app.delete();
      app = null;
    }
  });

  test('regular users can create sailing clubs', () async {
    final fs.Firestore _fbStore = fb.firestore();
    final fs.CollectionReference _fsRefSailingClubs = _fbStore.collection("sailing_clubs");
    final Map<String, dynamic> sailingClubMap = {'name': 'a test'};
    sailingClubMap['roles'] = {user.uid: 'owner'};
    final sailingClub = await _fsRefSailingClubs.add(sailingClubMap);
    assert(sailingClub.id != null);
  });
}
