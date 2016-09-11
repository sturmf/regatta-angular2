import 'dart:async';
import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'event_service.dart';
import 'event.dart';

@Component(
  selector: 'my-event-list',
  templateUrl: 'event_list_component.html',
  styleUrls: const ['event_list_component.css']
)
class EventListComponent implements OnInit {
  List<Event> events;

  final EventService _eventService;
  //final RouteParams _routeParams;

  EventListComponent(this._eventService) { //, this._routeParams) {
    print('EventListComponent constructor');
  }

  Future<Null> getEvents() async {
    events = await _eventService.getEvents();
  }

  ngOnInit() async {
    print('Init called');
    getEvents();
  }

  goBack() {
    window.history.back();
  }

}
