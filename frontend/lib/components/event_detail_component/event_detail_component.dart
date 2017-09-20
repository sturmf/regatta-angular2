import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/angular_components.dart';

import 'package:frontend/components/event_assistants_list_component/event_assistants_list_component.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/store/regatta_action.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/models/sailing_club.dart';

@Component(
    selector: 'my-event-detail',
    templateUrl: 'event_detail_component.html',
    styleUrls: const ['event_detail_component.css'],
    directives: const [CORE_DIRECTIVES, materialDirectives, EventAssistantsListComponent],
    providers: const [materialProviders])
class EventDetailComponent implements DoCheck {
  final RegattaStore _store;
  final RouteParams _routeParams;
  String selectedEvent;

  StringSelectionOptions<SailingClub> filteredSailingClubs;
  SelectionModel<SailingClub> singleSelectModel;
  Map<String, SailingClub> oldSailingClubs;
  SailingClub oldOrganizer;

  EventDetailComponent(this._store, this._routeParams) {
    selectedEvent = _routeParams.get('key');

    filteredSailingClubs =
        new StringSelectionOptions(_store.state.sailingClubs.values, toFilterableString: displayNameRenderer);
  }

  Event get event => _store.state.events[selectedEvent];

  String get raceCount => event.raceCount.toString();

  SailingClub get organizer => (event != null ) ? _store.state.sailingClubs[event.organizer] : null;

  Iterable<SailingClub> get sailingClubs => _store.state.sailingClubs.values;

  ItemRenderer<SailingClub> displayNameRenderer = (SailingClub item) => item.name;

  void ngDoCheck() {
    if (oldSailingClubs != _store.state.sailingClubs) {
      oldSailingClubs = _store.state.sailingClubs;
      filteredSailingClubs =
          new StringSelectionOptions(_store.state.sailingClubs.values, toFilterableString: displayNameRenderer);
    }
    if (oldOrganizer != organizer) {
      oldOrganizer = organizer;
      singleSelectModel = new SelectionModel<SailingClub>.withList(selectedValues: [organizer]);
      singleSelectModel.selectionChanges.listen(update); // FIXME: cancel subscription?
    }
  }

  void update(List<SelectionChangeRecord> record) {
    if (record.isNotEmpty && record.first.added.isNotEmpty) {
      onOrganizerChanged(record.first.added.first);
    }
  }

  void onDropdownVisibleChange(MaterialSelectSearchboxComponent searchbox, bool visible) {
    if (visible) {
      // TODO(google): Avoid using Timer.run.
      Timer.run(() {
        searchbox.focus();
      });
    }
  }

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
