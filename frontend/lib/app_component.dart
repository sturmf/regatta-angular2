import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';

import 'event_service.dart';


@Component(
  selector: 'my-app',
  template: '''
    <h1>My First Angular 2 App</h1>
    <div *ngFor="let event of events" (click)="onSelect(event)">
      <div>
        <h4>{{event.name}}</h4>
      </div>
    </div>
    Selected event
    {{selectedEvent?.name}}
    ''',
  directives: const [
    ROUTER_DIRECTIVES
  ],
  providers: const [
    ROUTER_PROVIDERS,
    const Provider(LocationStrategy, useClass: HashLocationStrategy),
    EventService
  ]
)


class AppComponent implements OnInit {
  List<Event> events;
  Event selectedEvent;

  final EventService _eventService;
  
  AppComponent(this._eventService);

  Future<Null> getEvents() async {
    events = await _eventService.getEvents();
  }
  ngOnInit() {
    getEvents();
  }

  void onSelect(Event event) {
    selectedEvent = event;
  }
}

