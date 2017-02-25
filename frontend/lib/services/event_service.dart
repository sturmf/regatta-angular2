import 'dart:async';
import 'dart:convert';
import 'package:angular2/core.dart';
import 'package:frontend/models/event.dart';
import 'package:http/http.dart';

@Injectable()
class EventService {
  static final Map<String, String> _headersGet = {'Accept': 'application/json'};
  static final Map<String, String> _headersPost = {'Content-Type': 'application/json', 'Accept': 'application/json'};
  final Client _http;

  // Hostname in development mode points to Django port 8000, in production we set it to empty during pub build
  static const String hostname = const String.fromEnvironment('hostname', defaultValue: 'http://localhost:8000');
  // URLs to the web API
  static const String _eventsUrl = hostname + '/api/events';

  EventService(this._http);

  // CRUD nomenclature
  Future<Event> addEvent(String name) async {
    // FIXME: rename to create
    print('EventService.addEvent() has been called with name=$name');
    try {
      final Response response =
          await _http.post('$_eventsUrl/', headers: _headersPost, body: JSON.encode({'name': name}));
      return new Event.fromJson(JSON.decode(response.body));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Iterable<Event>> getEvents() async {
    try {
      final Response response = await _http.get('$_eventsUrl/', headers: _headersGet);
      final List<Map<String, dynamic>> results = JSON.decode(response.body)['results'] as List<Map<String, dynamic>>;
      //print(results);
      final List<Event> events = results.map((e) => new Event.fromJson(e));
      return events;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Event> getEvent(int id) async {
    try {
      final Response response = await _http.get('$_eventsUrl/$id/', headers: _headersGet);
      final Event e = new Event.fromJson(JSON.decode(response.body));
      return e;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Event> updateEvent(Event event) async {
    try {
      final String url = '$_eventsUrl/${event.id}/';
      final Response response = await _http.put(url, headers: _headersPost, body: JSON.encode(event.toJson()));
      return new Event.fromJson(JSON.decode(response.body));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Null> deleteEvent(Event event) async {
    print('EventService.deleteEvent() has been called with event=$event');
    try {
      final String url = '$_eventsUrl/${event.id}/';
      /* final Response response = */
      await _http.delete(url, headers: _headersPost);
      // FIXME: what to return on failure?
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return new Exception('Server error; cause: $e');
  }
}
