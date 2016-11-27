import 'dart:async';
import 'dart:html' show window;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:frontend/store/RegattaStore.dart'; // FIXME: should just be store
import 'package:greencat/greencat.dart';

import 'package:frontend/services/event_service.dart';
import 'models/event.dart';

@Component(
    selector: 'my-event-list',
    templateUrl: 'event_list_component.html',
    styleUrls: const ['event_list_component.css'],
    directives: const [materialDirectives],
    providers: const [materialProviders])
class EventListComponent implements OnInit {
  List<Event> events;

  final EventService _eventService;
  final Router _router;
  final RegattaStore _store;

  EventListComponent(this._eventService, this._router, this._store);

  Future<Null> getEvents() async {
    events = await _eventService.getEvents();
  }

  @override
  void ngOnInit() {
    getEvents();

    print(_store.store.state);
    print('before dispatch');
    _store.store.dispatch(addEventX('test event'));
    print('after dispatch');
    print(_store.store.state);
  }

  Future<Null> addEvent(String name) async {
    print('EventListComponent.addEvent() has been called with name=$name');
    final Event event = await _eventService.addEvent(name);
    events.add(event);
  }

  void gotoEvent(Event event) {
    final List<dynamic> link = [
      'EventDetail',
      {'id': event.id.toString()}
    ];
    _router.navigate(link);
  }

  void goBack() {
    window.history.back();
  }
}
