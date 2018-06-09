import 'dart:async';

import 'package:angular/angular.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/services/algolia_service.dart';
import 'package:frontend/store/regatta_store.dart';

enum SearchDirection {
  initial, previous, next
}

@Injectable()
class DatabaseService {
  final RegattaStore _store;
  AlgoliaService _algoliaService;

  String _searchTerm = '';
  int _page = 0;
  int _pageSize = 2;

  DatabaseService(this._store) {
    _algoliaService = new AlgoliaService();
  }

  Future initialEvents() async {
    return _searchEntries(SearchDirection.initial);
  }

  Future nextEvents() async {
    return _searchEntries(SearchDirection.next);
  }

  Future previousEvents() async {
    return _searchEntries(SearchDirection.previous);
  }

  Future filterEvents(String filter) async {
    _searchTerm = filter.trim();
    return _searchEntries(SearchDirection.initial);
  }

  Future _searchEntries(SearchDirection direction) async {
    int page;
    switch (direction) {
      case SearchDirection.initial:
        page = 0;
        break;
      case SearchDirection.next:
        page = _page + 1;
        break;
      case SearchDirection.previous:
        page = _page - 1;
        break;
    }
    final data  = await _algoliaService.search(_searchTerm, page, _pageSize);
    final eventList = _parseEvents(data);
    if (eventList.isNotEmpty || direction == SearchDirection.initial) {
      _updateEvents(eventList);
      _setVisibleEvents(eventList);
      _page = page;
    }
  }

  List<Event> _parseEvents(data) {
    final List<Event> eventList = new List();
    if (data.containsKey('hits')) {
      for (var snapshot in data['hits']) {
        final Event event = new Event.fromMap(snapshot['objectID'], snapshot);
        eventList.add(event);
      }
    }
    return eventList;
  }

  void _updateEvents(List<Event> eventList) {
    for (var event in eventList) {
      _store.dispatch(_store.action.addEvent(event));
    }
  }

  void _setVisibleEvents(List<Event> eventList) {
    final List<String> eventKeys = eventList.map((ev) => ev.key);
    _store.dispatch(_store.action.selectedEvents(eventKeys));
  }

}