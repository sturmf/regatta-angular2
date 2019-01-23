import 'dart:async';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:http/browser_client.dart' as http;
//import 'package:http/http.dart' as http;

@Injectable()
class AlgoliaService {
  AlgoliaService() {
    _client = new http.BrowserClient();
  }

  final _eventUrl = "https://DXJQDY655R-dsn.algolia.net/1/indexes/events/query";
  final _headers = {'X-Algolia-Application-Id': 'DXJQDY655R', 'X-Algolia-API-Key': 'd25d9cff0c3595b2a39d68592ea31197'};

  //http.BaseClient _client;
  http.BrowserClient _client;

  Future<Map<String, dynamic>> search(String searchTerm, int page, int pageSize) async {
    //_filterList = filter.trim().split(new RegExp(r"\s+"));
    if (page < 0 || pageSize < 0) {
      return {};
    }

    final query = Uri.encodeQueryComponent(searchTerm);
    final body = '{"params": "query=$query&hitsPerPage=$pageSize&page=$page"}';

    final response = await _client.post(_eventUrl, headers: _headers, body: body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    return {};
  }
}
