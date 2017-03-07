import 'package:test/test.dart';
import 'package:frontend/models/event.dart';

void main() {
  final dataJsonDefault = {
    'key': "abc",
    'name': null,
    'start_date': '2017-02-13',
    'end_date': '2017-02-13',
    'race_count': null,
    'race_unrated_on': null,
    'organizer': null,
    'race_committee': null,
    'umpire': null,
    'assistants': null
  };

  final dataJson = {
    'key': "abc",
    'name': 'Christmas Race',
    'start_date': '2017-02-12',
    'end_date': '2017-02-13',
    'race_count': 6,
    'race_unrated_on': '4',
    'organizer': 'http://localhost:8000/api/persons/1/',
    'race_committee': 'http://localhost:8000/api/persons/2/',
    'umpire': 'http://localhost:8000/api/persons/3/',
    'assistants': null
  };

  test('serialize event without parameters', () {
    final event = new Event("abc", 'http://localhost:8000/api/events/1/');
    final json = event.toMap();
    expect(json, dataJsonDefault);
  });

  test('serialize event with given parameters', () {
    final event = new Event(
        "abc",
        'Christmas Race',
        new DateTime(2017, 2, 12),
        new DateTime(2017, 2, 13),
        6,
        '4',
        'http://localhost:8000/api/persons/1/',
        'http://localhost:8000/api/persons/2/',
        'http://localhost:8000/api/persons/3/');
    final json = event.toMap();
    expect(json, dataJson);
  });

  test('deserialize and serialize roudtrip of event', () {
    final event = new Event.fromMap("abc", dataJson);
    final json = event.toMap();
    expect(json, dataJson);
  });
}
