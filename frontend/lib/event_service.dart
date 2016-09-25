import 'dart:async';
import 'dart:convert';

import 'package:angular2/core.dart';
import 'package:http/http.dart';

import 'models/event.dart';
import 'models/sailing_club.dart';
import 'models/person.dart';


@Injectable()
class EventService {

  static final _headers = {'Content-Type': 'application/json'};
  final Client _http;

  // URLs to the web API
  static const _eventsUrl = 'http://localhost:8000/api/events';
  static const _sailingClubsUrl = 'http://localhost:8000/api/sailing_clubs';
  static const _personsUrl = 'http://localhost:8000/api/persons';

  EventService(this._http);

  Future<List<Event>> getEvents() async {
    try {
      final response = await _http.get('$_eventsUrl/');
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
      final response = await _http.get('$_eventsUrl/$id/');
      final event = new Event.fromJson(JSON.decode(response.body));
      return event;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<SailingClub>> getSailingClubs() async {
    try {
      final response = await _http.get('$_sailingClubsUrl/');
      final sailing_clubs = JSON.decode(response.body)['results'].map((value) => new SailingClub.fromJson(value)).toList();
      return sailing_clubs;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Person>> getPersons() async {
    try {
      final response = await _http.get('$_personsUrl/');
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
          await _http.put(url, headers: _headers, body: JSON.encode(event));
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
