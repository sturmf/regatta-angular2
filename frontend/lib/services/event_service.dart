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

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return new Exception('Server error; cause: $e');
  }
}
