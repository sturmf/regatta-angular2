import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/angular_components.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/store/regatta_action.dart';
import 'package:frontend/models/event.dart';

@Component(
    selector: 'my-event-list',
    templateUrl: 'event_list_component.html',
    styleUrls: const ['event_list_component.css'],
    directives: const [CORE_DIRECTIVES, materialDirectives],
    //changeDetection: ChangeDetectionStrategy.OnPush,
    providers: const [materialProviders])
class EventListComponent {
  final Router _router;
  final RegattaStore _store;

  EventListComponent(this._router, this._store);

  String eventName = '';
  Iterable<Event> get events => _store.state.events.values;

  // FIXME: should come from store
  bool get canAddEvents {
    return _store.state.currentUser != null;
  }

  Future joinEventHandler(Event event) async {
    print("FIXME: now emit a join event??");
  }

  void addNewEventHandler() {
    if (eventName.length > 0) {
      _store.dispatch(requestCreateEvent(eventName));
      eventName = '';
    }
  }

  void deleteEventHandler(Event event) {
    _store.dispatch(requestDeleteEvent(event));
  }

  void gotoEvent(Event event) {
    final List<dynamic> link = [
      'EventDetail',
      {'key': event.key}
    ];
    _router.navigate(link);
  }
}
