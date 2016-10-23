import 'dart:async';
import 'dart:convert';
import 'package:angular2/core.dart';
import 'package:dson/dson.dart';
import 'package:frontend/models/event.dart';
import 'package:http/http.dart';


@Injectable()
class EventService {

  static final _headersGet = {'Accept': 'application/json'};
  static final _headersPost = {'Content-Type': 'application/json'};
  final Client _http;

  // Hostname in development mode points to Django port 8000, in production we set it to empty during pub build
  static const hostname = const String.fromEnvironment('hostname', defaultValue: 'http://localhost:8000');
  // URLs to the web API
  static const _eventsUrl = hostname + '/api/events';

  EventService(this._http);

  // CRUD nomenclature
  Future<Event> addEvent(String name) async {
    print('EventService.addEvent() has been called with name=$name');
    try {
      final response =
          await _http.post('$_eventsUrl/', headers: _headersPost, body: JSON.encode({'name': name}));
      return fromJson(response.body, Event);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Event>> getEvents() async {
    try {
      final response = await _http.get('$_eventsUrl/', headers: _headersGet);
      final results = JSON.decode(response.body)['results'];
      final events = fromMapList(results, Event);
      return events;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Event> getEvent(int id) async {
    try {
      final response = await _http.get('$_eventsUrl/$id/', headers: _headersGet);
      Event e = fromJson(response.body, Event);
      return e;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Event> update(Event event) async {
    try {
      var url = '$_eventsUrl/${event.id}/';
      final response =
          await _http.put(url, headers: _headersPost, body: toJson(event));
      return fromJson(response.body, Event);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return new Exception('Server error; cause: $e');
  }

}
