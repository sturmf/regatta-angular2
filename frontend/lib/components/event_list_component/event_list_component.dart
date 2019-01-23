import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/angular_components.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:frontend/routes.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/models/event.dart';

@Component(selector: 'my-event-list', templateUrl: 'event_list_component.html', styleUrls: const [
  'event_list_component.css'
], directives: const [
  coreDirectives,
  materialInputDirectives,
  MaterialFabComponent,
  MaterialButtonComponent,
  MaterialIconComponent,
  MaterialDialogComponent,
  ModalComponent
], providers: const [
  materialProviders
], pipes: const [
  commonPipes
])
class EventListComponent {
  EventListComponent(this._router, this._store) {
    _searchTerms.stream.transform(debounce(new Duration(milliseconds: 300))).distinct().listen(_search);
    // On creation load the list of Events
    // FIXME: don't start at the beginning but e.g. at current date
    _store.dispatch(_store.action.requestInitialEvents());
  }

  bool showAddDialog = false;
  String newEventName = '';

  final Router _router;
  final RegattaStore _store;
  StreamController<String> _searchTerms = new StreamController<String>.broadcast();

  Map<String, Event> get events => _store.state.events;
  Iterable<String> get eventList => _store.state.eventList;

  // Push a search term into the stream.
  void search(String term) => _searchTerms.add(term);

  void _search(String term) {
    _store.dispatch(_store.action.requestFilterEvents(term));
  }

  bool get canAddEvents {
    return _store.state.currentUser != null;
  }

  Future joinEventHandler(Event event) async {
    print("FIXME: now emit a join event??");
  }

  void dismissNewEventDialog() {
    newEventName = '';
    showAddDialog = false;
  }

  void addNewEventHandler() {
    if (newEventName.length > 0) {
      _store.dispatch(_store.action.requestCreateEvent(newEventName));
    }
    dismissNewEventDialog();
  }

  void deleteEventHandler(Event event) {
    _store.dispatch(_store.action.requestDeleteEvent(event));
  }

  void gotoEvent(Event event) {
    _router.navigate(RoutePaths.event.toUrl(parameters: {'key': event.key}));
  }

  void previous() {
    _store.dispatch(_store.action.requestPreviousEvents());
  }

  void next() {
    _store.dispatch(_store.action.requestNextEvents());
  }
}
