import 'dart:async';
import 'dart:html' show window;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:frontend/services/event_service.dart';
import 'models/event.dart';

@Component(
    selector: 'my-event-list', templateUrl: 'event_list_component.html', styleUrls: const ['event_list_component.css'])
class EventListComponent implements OnInit {
  List<Event> events;

  final EventService _eventService;
  final Router _router;

  EventListComponent(this._eventService, this._router);

  Future<Null> getEvents() async {
    events = await _eventService.getEvents();
  }

  @override
  void ngOnInit() {
    getEvents();
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
