import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/angular_components.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/models/event.dart';

@Component(
    selector: 'my-event-list',
    templateUrl: 'event_list_component.html',
    styleUrls: const ['event_list_component.css'],
    directives: const [CORE_DIRECTIVES, materialDirectives],
    providers: const [materialProviders],
    pipes: const [COMMON_PIPES],)
class EventListComponent {
  final Router _router;
  final RegattaStore _store;

  EventListComponent(this._router, this._store) {
    // On creation load the list of Events
    // FIXME: don't start at the beginning but e.g. at current date
    _store.dispatch(_store.action.requestNextEvents(null));
  }

  String eventName = '';
  Map<String, Event> get events => _store.state.events;
  Iterable<String> get eventList => _store.state.eventList;

  // FIXME: should come from store
  bool get canAddEvents {
    return _store.state.currentUser != null;
  }

  Future joinEventHandler(Event event) async {
    print("FIXME: now emit a join event??");
  }

  void addNewEventHandler() {
    if (eventName.length > 0) {
      _store.dispatch(_store.action.requestCreateEvent(eventName));
      eventName = '';
    }
  }

  void deleteEventHandler(Event event) {
    _store.dispatch(_store.action.requestDeleteEvent(event));
  }

  void gotoEvent(Event event) {
    final List<dynamic> link = [
      'EventDetail',
      {'key': event.key}
    ];
    _router.navigate(link);
  }

  void previous() {
    _store.dispatch(_store.action.requestPreviousEvents(_store.state.eventList.first));
  }

  void next() {
    _store.dispatch(_store.action.requestNextEvents(_store.state.eventList.last));
  }
}
