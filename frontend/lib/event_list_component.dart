import 'dart:html' show KeyboardEvent;
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/store/regatta_action.dart';

import 'models/event.dart';

@Component(
    selector: 'my-event-list',
    templateUrl: 'event_list_component.html',
    styleUrls: const ['event_list_component.css'],
    directives: const [materialDirectives],
    //changeDetection: ChangeDetectionStrategy.OnPush,
    providers: const [materialProviders])
class EventListComponent {
  final Router _router;
  final RegattaStore _store;

  EventListComponent(this._router, this._store);

  String eventName = '';
  Iterable<Event> get events => _store.state.events;

  void onKeyDown(KeyboardEvent key) {
    if (key.keyCode == 13) {
      addNewEventHandler();
    }
  }

  void addNewEventHandler() {
    _store.dispatch(requestCreateEvent(eventName));
    eventName = '';
  }

  void deleteEventHandler(Event event) {
    print('delete $event');
    _store.dispatch(requestDeleteEvent(event));
  }

  // FIXME: rewrite as redux change
  void gotoEvent(Event event) {
    final List<dynamic> link = [
      'EventDetail',
      {'id': event.id.toString()}
    ];
    _router.navigate(link);
  }
}
