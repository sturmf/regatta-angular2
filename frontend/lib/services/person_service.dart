import 'dart:async';
import 'dart:convert';
import 'package:angular2/angular2.dart';
import 'package:dson/dson.dart';
import 'package:frontend/models/person.dart';
import 'package:http/http.dart';

@Injectable()
class PersonService {
  PersonService(this._http);

  final Client _http;

  static final Map<String, String> _headersGet = {'Accept': 'application/json'};
  //static final Map<String, String> _headersPost = {'Content-Type': 'application/json', 'Accept': 'application/json'};

  // Hostname in development mode points to Django port 8000, in production we set it to empty during pub build
  static const String hostname = const String.fromEnvironment('hostname', defaultValue: 'http://localhost:8000');

  static const String _personsUrl = hostname + '/api/persons';

  Future<Iterable<Person>> getPersons([Map<String, dynamic> search]) async {
    try {
      final Response response = await _http.get('$_personsUrl/?${encodeMap(search)}', headers: _headersGet);
      final List<Map<dynamic, dynamic>> results = JSON.decode(response.body)['results'] as List<Map<dynamic, dynamic>>;
      final List<Person> persons = fromMapList(results, Person) as List<Person>;
      return persons;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return new Exception('Server error; cause: $e');
  }

  String encodeMap(Map<String, dynamic> data) {
    if (data == null) return '';
    return data.keys.map((String k) {
      return '${Uri.encodeComponent(k)}=${Uri.encodeComponent(data[k])}';
    }).join('&');
  }
}
