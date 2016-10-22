import 'dart:async';
import 'dart:html' show window;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:frontend/services/event_service.dart';
import 'models/event.dart';

@Component(
  selector: 'my-event-list',
  templateUrl: 'event_list_component.html',
  styleUrls: const ['event_list_component.css']
)
class EventListComponent implements OnInit {
  List<Event> events;

  final EventService _eventService;
  final Router _router;

  EventListComponent(this._eventService, this._router);

  Future getEvents() async {
    events = await _eventService.getEvents();
  }

  ngOnInit() async {
    print('Init called');
    getEvents();
  }

  Future<Null> addEvent(String name) async {
    print('EventListComponent.addEvent() has been called with name=$name');
    Event event = await _eventService.addEvent(name);
    events.add(event);
  }

  gotoEvent(Event event) {
    var link = ['EventDetail', {'id': event.id.toString()}];
    _router.navigate(link);
  }

  goBack() {
    window.history.back();
  }

}
