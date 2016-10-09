import 'dart:async';
import 'dart:convert';

import 'package:angular2/core.dart';
import 'package:http/http.dart';

import 'models/event.dart';
import 'models/sailing_club.dart';
import 'models/person.dart';


@Injectable()
class EventService {

  static final _headersGet = {'Accept': 'application/json'};
  static final _headersPost = {'Content-Type': 'application/json'};
  final Client _http;

  // Hostname in development mode points to Django port in production we set it to empty in pubspec.yml
  static const hostname = const String.fromEnvironment('hostname', defaultValue: 'http://localhost:8000');
  // URLs to the web API
  static const _eventsUrl = hostname + '/api/events';
  static const _sailingClubsUrl = hostname + '/api/sailing_clubs';
  static const _personsUrl = hostname + '/api/persons';

  EventService(this._http);

  Future<List<Event>> getEvents() async {
    try {
      final response = await _http.get('$_eventsUrl/', headers: _headersGet);
      final events = _extractData(response)
          .map((value) => new Event.fromJson(value))
          .toList();
      return events;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Event> getEvent(int id) async {
    try {
      final response = await _http.get('$_eventsUrl/$id/', headers: _headersGet);
      final event = new Event.fromJson(JSON.decode(response.body));
      return event;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<SailingClub>> getSailingClubs() async {
    try {
      final response = await _http.get('$_sailingClubsUrl/', headers: _headersGet);
      final sailing_clubs = JSON.decode(response.body)['results'].map((value) => new SailingClub.fromJson(value)).toList();
      return sailing_clubs;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Person>> getPersons() async {
    try {
      final response = await _http.get('$_personsUrl/', headers: _headersGet);
      final persons = JSON.decode(response.body)['results'].map((value) => new Person.fromJson(value)).toList();
      return persons;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Event> update(Event event) async {
    try {
      var url = '$_eventsUrl/${event.id}/';
      final response =
          await _http.put(url, headers: _headersPost, body: JSON.encode(event));
      return new Event.fromJson(JSON.decode(response.body));
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) => JSON.decode(resp.body)['results'];

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return new Exception('Server error; cause: $e');
  }

}
