import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';

import 'package:frontend/components/event_assistants_list_component/event_assistants_list_component.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/store/regatta_action.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/models/sailing_club.dart';

@Component(
    selector: 'my-event-detail',
    templateUrl: 'event_detail_component.html',
    styleUrls: const ['event_detail_component.css'],
    directives: const [materialDirectives, EventAssistantsListComponent],
    providers: const [materialProviders])
class EventDetailComponent {
  final RegattaStore _store;
  final RouteParams _routeParams;
  String selectedEvent;

  EventDetailComponent(this._store, this._routeParams) {
    selectedEvent = _routeParams.get('key');
  }

  Event get event => _store.state.events[selectedEvent];

  String get raceCount => event.raceCount.toString();

  SailingClub get organizer => _store.state.sailingClubs[event.organizer];

  Iterable<SailingClub> get sailingClubs => _store.state.sailingClubs.values;

  void onNameChanged(String data) {
    _store.dispatch(requestUpdateEvent(_store.state.events[selectedEvent].copy(name: data)));
  }

  // FIXME: workaround for a missing date picker
  void onStartDateChanged(String data) {
    try {
      _store.dispatch(requestUpdateEvent(_store.state.events[selectedEvent].copy(startDate: DateTime.parse(data))));
    } on FormatException {
      // FIXME: what to do then?
    }
  }

  // FIXME: workaround for a missing date picker
  void onEndDateChanged(String data) {
    try {
      _store.dispatch(requestUpdateEvent(_store.state.events[selectedEvent].copy(endDate: DateTime.parse(data))));
    } on FormatException {
      // FIXME: what to do then?
    }
  }

  void onRaceCountChanged(String data) {
    try {
      _store.dispatch(requestUpdateEvent(_store.state.events[selectedEvent].copy(raceCount: int.parse(data))));
    } on FormatException {
      // FIXME: what to do then?
    }
  }

  void onOrganizerChanged(SailingClub data) {
    _store.dispatch(requestUpdateEvent(_store.state.events[selectedEvent].copy(organizer: data.key)));
  }
}
