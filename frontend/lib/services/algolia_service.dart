import 'dart:async';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:http/browser_client.dart' as http;
//import 'package:http/http.dart' as http;
import 'package:frontend/models/event.dart';
import 'package:frontend/store/regatta_store.dart';


@Injectable()
class AlgoliaService {
  final _event_url = "https://DXJQDY655R-dsn.algolia.net/1/indexes/events/query";
  final _headers = {
    'X-Algolia-Application-Id': 'DXJQDY655R',
    'X-Algolia-API-Key': 'd25d9cff0c3595b2a39d68592ea31197'
  };

  //http.BaseClient _client;
  http.BrowserClient _client;

  final RegattaStore _store;

  AlgoliaService(this._store) {
    _client = new http.BrowserClient();
  }


  Future<Map<String, dynamic>> search() async {
    final response = await _client.post(_event_url, headers: _headers, body: '{"params": "query=&hitsPerPage=2"}');
    if (response.statusCode == 200) {
      return JSON.decode(response.body) as Map<String, dynamic>;
    }
    return {};
  }

  Future nextEvents() async {
    final List<String> eventList = new List();
    final response = await _client.post(_event_url, headers: _headers, body: '{"params": "query=&hitsPerPage=2"}');
    if (response.statusCode == 200) {
      final body = JSON.decode(response.body) as Map<String, dynamic>;

      // Send all received events
      for (var snapshot in body['hits']) {
        final Event ev = new Event.fromMap(snapshot['objectID'], snapshot);
        eventList.add(ev.key);
        _store.dispatch(_store.action.addEvent(ev));
      }
      // only update list of selected events if it is not empty, reversed if descending
      if (eventList.isNotEmpty) {
        _store.dispatch(_store.action.selectedEvents(eventList));
      }
    }
  }

}

