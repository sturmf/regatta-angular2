import 'dart:async';
import 'dart:convert';
import 'package:angular2/core.dart';
import 'package:dson/dson.dart';
import 'package:frontend/models/sailing_club.dart';
import 'package:http/http.dart';


@Injectable()
class SailingClubService {

  static final Map<String, String> _headersGet = {'Accept': 'application/json'};
  //static final Map<String, String> _headersPost = {'Content-Type': 'application/json', 'Accept': 'application/json'};
  final Client _http;

  // Hostname in development mode points to Django port 8000, in production we set it to empty during pub build
  static const hostname = const String.fromEnvironment('hostname', defaultValue: 'http://localhost:8000');
  // URLs to the web API
  static const _sailingClubsUrl = hostname + '/api/sailing_clubs';

  SailingClubService(this._http);

  Future<Iterable<SailingClub>> getSailingClubs() async {
    try {
      final response = await _http.get('$_sailingClubsUrl/', headers: _headersGet);
      final results = JSON.decode(response.body)['results'] as List<Map>;
      final sailing_clubs = fromMapList(results, SailingClub) as List<SailingClub>;
      return sailing_clubs;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return new Exception('Server error; cause: $e');
  }

}
