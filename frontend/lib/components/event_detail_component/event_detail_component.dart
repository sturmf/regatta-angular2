import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/angular_components.dart';

import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/models/sailing_club.dart';
import 'package:frontend/routes.dart';

@Component(selector: 'my-event-detail', templateUrl: 'event_detail_component.html', styleUrls: const [
  'event_detail_component.css'
], directives: const [
  coreDirectives,
  MaterialTabPanelComponent,
  MaterialTabComponent,
  materialInputDirectives,
  materialNumberInputDirectives,
  MaterialDropdownSelectComponent,
  MaterialSelectSearchboxComponent
], providers: const [
  materialProviders
])
class EventDetailComponent implements OnActivate {
  EventDetailComponent(this._store) {
    // FIXME: subscribe to updates, since we no longer subscribe to every document
  }

  String selectedEvent;

  final RegattaStore _store;
  // We need those to detect state changes in the store without deep equality check of the map
  StringSelectionOptions<SailingClub> _filteredSailingClubs;
  Map<String, SailingClub> _oldSailingClubs;
  SelectionModel<SailingClub> _singleSelectModel;
  SailingClub _oldOrganizer;
  StreamSubscription _selectionListener;

  @override
  void onActivate(_, RouterState current) async {
    selectedEvent = current.parameters[keyParam];
  }

  bool get canEdit => true; // FIXME: needs to depend on permissions

  Event get event => _store.state.events[selectedEvent];

  int get raceCount => event.raceCount;

  SailingClub get organizer => _store.state.sailingClubs[event.organizer];

  Iterable<SailingClub> get sailingClubs => _store.state.sailingClubs.values;

  ItemRenderer<dynamic> displayNameRenderer = (dynamic item) => item.name;

  StringSelectionOptions<SailingClub> get filteredSailingClubs {
    // We have to save the old state since the Iterable itself is unstable and would change all the time
    if (_oldSailingClubs != _store.state.sailingClubs) {
      _oldSailingClubs = _store.state.sailingClubs;
      _filteredSailingClubs = new StringSelectionOptions(_store.state.sailingClubs.values.toList(),
          toFilterableString: displayNameRenderer);
    }
    return _filteredSailingClubs;
  }

  SelectionModel<SailingClub> get singleSelectModel {
    // We have to update the selection model on organizer change
    if (_singleSelectModel == null || _oldOrganizer != organizer) {
      _oldOrganizer = organizer;
      _singleSelectModel = new SelectionModel<SailingClub>.single(selected: organizer);
      _selectionListener?.cancel();
      _selectionListener = _singleSelectModel.selectionChanges.listen(update);
    }
    return _singleSelectModel;
  }

  void update(List<SelectionChangeRecord> record) {
    if (record.isNotEmpty && record.first.added.isNotEmpty) {
      onOrganizerChanged(record.first.added.first);
    }
  }

  void onDropdownVisibleChange(MaterialSelectSearchboxComponent searchBox, bool visible) {
    if (visible) {
      // TODO(google): Avoid using Timer.run.
      Timer.run(() {
        searchBox.focus();
      });
    }
  }

  void onNameChanged(String data) {
    _store.dispatch(_store.action.requestUpdateEvent(_store.state.events[selectedEvent].copy(name: data)));
  }

  // FIXME: workaround for a missing date picker
  void onStartDateChanged(String data) {
    try {
      _store.dispatch(
          _store.action.requestUpdateEvent(_store.state.events[selectedEvent].copy(startDate: DateTime.parse(data))));
    } on FormatException {
      // FIXME: what to do then?
    }
  }

  // FIXME: workaround for a missing date picker
  void onEndDateChanged(String data) {
    try {
      _store.dispatch(
          _store.action.requestUpdateEvent(_store.state.events[selectedEvent].copy(endDate: DateTime.parse(data))));
    } on FormatException {
      // FIXME: what to do then?
    }
  }

  void onRaceCountChanged(String data) {
    try {
      _store.dispatch(
          _store.action.requestUpdateEvent(_store.state.events[selectedEvent].copy(raceCount: int.parse(data))));
    } on FormatException {
      // FIXME: what to do then?
    }
  }

  void onOrganizerChanged(SailingClub data) {
    _store.dispatch(_store.action.requestUpdateEvent(_store.state.events[selectedEvent].copy(organizer: data.key)));
  }
}
